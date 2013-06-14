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
    @products = Product.where(:top_design => true)
  end

  def all_partners
    @partners = Partner.all
  end

  #All the rooms by a given a partner. This method shows only the rooms in which there is at least a product
  #distributed by the partner choosen.

  def rooms_by_partner
    @rooms_by_partner= Array.new
    @products_by_room_partner = Array.new

    @partner = Partner.find(params[:productor_id])


    @rooms = Room.all
    @rooms.each do |room|
      @products_by_room_partner= Product.where("room_id  = ? AND productor_id = ?", room.id, @partner.id)
      if(@products_by_room_partner.count >= 1)
        @rooms_by_partner.push(room)
      end
    end
  end

  def our_rooms
    @group = Group.find(params[:group_id])
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
    @partner = Partner.find(params[:productor_id])

    @categories_by_room_partner = Array.new
    @products_by_category_room_partner = Array.new

    @categories = Category.all
    @categories.each do |category|
      @products_by_category_room_partner= Product.where("room_id  = ? AND productor_id = ? AND category_id = ?", @room_by_partner.id, @partner.id, category.id)
      if(@products_by_category_room_partner.count >= 1)
        @categories_by_room_partner.push(category)
      end
    end
  end
    # All the products by a given category, a given room and a given partner

    def products_by_category_by_room_by_partner
      @partner = Partner.find(params[:productor_id])
      @room = Room.find(params[:room_id])
      @category = Category.find(params[:category_id])

      @products_by_category_room_partner = Product.where("productor_id = ? AND room_id = ? AND category_id = ?", @partner.id,@room.id,@category.id)

    end



  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    @designer = @product.designer

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
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

    is_our_product = params[:product][:is_our_product]

    if is_our_product
      @product.manufacturer = Group.first_or_create!
    else
      @product.manufacturer = Partner.find(params[:product][:manufacturer])
    end


    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    @product = Product.find(params[:id])

    @product.name = params[:product][:name]
    @product.description = params[:product][:description]

    category = Category.find(params[:product][:category_id])

    @product.category = category;

    room = Room.find(params[:product][:room_id])

    @product.room = room

    designer = Designer.find(params[:product][:designer_id])

    @product.designer = designer

    partner = Partner.find(params[:product][:productor_id])

    @product.productor = partner

    @product.top_design = params[:product][:top_design]

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
