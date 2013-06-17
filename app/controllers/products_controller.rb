class ProductsController < ApplicationController


  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @group = Group.first_or_create!

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  #This method shows the list of the products classified as "Top_design" products.

  def top_design
    session[:product_back_url] = request.url
    @products = Product.where(:top_design => true)
  end

  def all_partners
    @partners = Partner.all
  end

  #All the rooms by a given a partner. This method shows only the rooms in which there is at least a product
  #distributed by the partner chosen.

  def rooms_by_partner
    @rooms_by_partner= Array.new
    @products_by_room_partner = Array.new

    @partner = Partner.find(params[:manufacturer_id])


    @rooms = Room.all
    @rooms.each do |room|
      @products_by_room_partner = @partner.products.where(:room_id => room.id)
      #Product.where("room_id  = ? AND manufacturer_id = ?", room.id, @partner.id)
      if(@products_by_room_partner.count >= 1)
        @rooms_by_partner.push(room)
      end
    end
  end

  def our_rooms
    @group = Group.find(params[:manufacturer_id])
    @rooms = Room.all
    @our_rooms = Array.new
    @our_products = @group.products

    @our_products.each do |product|
      room = product.room
      if(!@our_rooms.include?(room))
        @our_rooms.push(room)
      end
    end

  end

  #All the categories by a given a partner. This method shows only the categories in which there is at least a product
  #distributed by the partner choosen.

  def categories_by_room_by_partner
    @room_by_partner= Room.find(params[:room_id])
    @partner = Partner.find(params[:manufacturer_id])

    @categories_by_room_partner = Array.new
    @products_by_category_room_partner = Array.new

    @categories = Category.all
    @categories.each do |category|

      @products_by_category_room_partner = @partner.products.where(:room_id => @room_by_partner.id, :category_id => category.id)

      if(@products_by_category_room_partner.count >= 1)
        @categories_by_room_partner.push(category)
      end
    end
  end

  #All the categories of our products. This method shows only the categories in which there is at least a product
  #distributed by us.
  def our_categories_by_room
    @group = Group.first_or_create!
    @our_room = Room.find(params[:room_id])
    @our_categories_by_room = Array.new
    @our_products_by_room = Group.first_or_create!.products.where(:room_id => @our_room.id)

    @our_products_by_room.each do |op|
      if(!@our_categories_by_room.include?(op.category))
        @our_categories_by_room.push(op.category)
      end
    end
  end
    # All the products by a given category, a given room and a given partner

    def products_by_category_by_room_by_partner
      session[:product_back_url] = request.url
      @partner = Partner.find(params[:manufacturer_id])
      @room = Room.find(params[:room_id])
      @category = Category.find(params[:category_id])

      @products_by_category_room_partner = @partner.products.where(:room_id => @room.id, :category_id => @category.id)
    end

  #All our products by a given category and a give room.
  def our_products_by_category_room
    session[:product_back_url] = request.url


    @group = Group.first_or_create!
    @room = Room.find(params[:room_id])
    @category = Category.find(params[:category_id])

    @our_products_by_room_by_category = @group.products.where(:room_id => @room.id, :category_id => @category.id)
  end


  #choose product
  def choose_product
    @product = Product.find(params[:product_id])

  end

  #add service to a product

  def add_service_to_product
    @product = Product.find(params[:product_id])

    @product.services << Service.find(params[:service][:id])

  end

  def choose_service
    @services = Service.all
    @product = Product.find(params[:product_id])
  end
  #add a photo to a product

  def add_photo_to_product
    @product = Product.find(params[:product_id])

    # retrieve image extension
    extension = params[:photo].original_filename.split('.').last

    # create a tmp file
    id = 0
    images_path = Rails.root.join('app', 'assets', 'images')
    img_name = "product-#{id.to_s}"

    while File.exist?(File.join(images_path, "#{img_name}.#{extension}")) do
      id += 1
      img_name = "product-#{id.to_s}"
    end

    # create a new image
    image = Image.new
    image.name = img_name
    image.extension = extension

    # create association between designer and its image
    @product.images << image

    # save to temp file
    File.open(File.join(images_path, "#{img_name}.#{extension}"), 'wb') do |f|
      f.write params[:photo].read
    end

  end

  def admin_page
    @products = Product.all
  end
  # GET /products/1
  # GET /products/1.json
  def show
    @back_url = session[:product_back_url]

    @product = Product.find(params[:id])

    @designer = @product.designer

    @collection = Array.new

    @guided_tour = false

    if params[:manufacturer_id] && params[:room_id] && params[:category_id] && params[:manufacturer_type]

      manufacturer_type = params[:manufacturer_type]
      manufacturer_id = params[:manufacturer_id]
      room_id = params[:room_id]
      category_id = params[:category_id]

      @guided_tour = true
      @collection = Product.where(:room_id => room_id, :manufacturer_id => manufacturer_id, :category_id => category_id, :manufacturer_type => manufacturer_type)
      current_index = @collection.index(@product)

      if current_index + 1 >= @collection.size
        next_index = 0
      else
        next_index = current_index + 1
      end

      if current_index < 0
        prev_index = @collection.size - 1
      else
        prev_index = current_index - 1
      end

      @next = @collection[next_index]
      @previous = @collection[prev_index]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end


  def technical_details
    @product = Product.find(params[:id])
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new

    @product.name = params[:product][:name]
    @product.description = params[:product][:description]

    @product.category = Category.find(params[:product][:category_id])

    @product.room = Room.find(params[:product][:room_id])

    @product.designer = Designer.find(params[:product][:designer_id])

    @product.top_design = params[:product][:top_design]

    @product.technical_details = params[:product][:technical_details]

    is_our_product = params[:is_our_product]

    if is_our_product.to_i > 0
      group = Group.first_or_create!
      group.products << @product
    else
      partner = Partner.find(params[:product][:manufacturer])
      partner.products << @product
    end


    # retrieve image extension
    extension = params[:product][:photo].original_filename.split('.').last

    # create a tmp file
    id = 0
    images_path = Rails.root.join('app', 'assets', 'images')
    img_name = "product-#{id.to_s}"

    while File.exist?(File.join(images_path, "#{img_name}.#{extension}")) do
      id += 1
      img_name = "product-#{id.to_s}"
    end

    # create a new image
    image = Image.new
    image.name = img_name
    image.extension = extension

    # create association between designer and its image
    @product.images << image

    # save to temp file
    File.open(File.join(images_path, "#{img_name}.#{extension}"), 'wb') do |f|
      f.write params[:product][:photo].read
    end



    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.new

    if params[:product][:name]
      @product.name = params[:product][:name]
    end
    if params[:product][:description]
      @product.description = params[:product][:description]
    end

    if params[:product][:category_id]
      @product.category = Category.find(params[:product][:category_id])
    end

    if params[:product][:room_id]
      @product.room = Room.find(params[:product][:room_id])
    end
    if params[:product][:top_design]
     @product.top_design = params[:product][:top_design]
    end
    if params[:product][:designer_id]
      @product.designer = Designer.find(params[:product][:designer_id])
    end

    if params[:product][:is_our_product] || params[:product][:manufacturer]
      is_our_product = params[:product][:is_our_product]

      if is_our_product == 1
       @product.manufacturer = Group.first_or_create!
     else
       @product.manufacturer = Partner.find(params[:product][:manufacturer])
     end
    end

    # retrieve image extension
    extension = params[:product][:photo].original_filename.split('.').last

    # create a tmp file
    id = 0
    images_path = Rails.root.join('app', 'assets', 'images')
    img_name = "product-#{id.to_s}"

    while File.exist?(File.join(images_path, "#{img_name}.#{extension}")) do
      id += 1
      img_name = "product-#{id.to_s}"
    end

    # create a new image
    image = Image.new
    image.name = img_name
    image.extension = extension

    # create association between designer and its image
    @product.images << image

    # save to temp file
    File.open(File.join(images_path, "#{img_name}.#{extension}"), 'wb') do |f|
      f.write params[:product][:photo].read
    end

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
