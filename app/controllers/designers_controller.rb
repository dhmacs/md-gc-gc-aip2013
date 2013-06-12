class DesignersController < ApplicationController
  # GET /designers
  # GET /designers.json
  def index
    @designers = Designer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @designers }
    end
  end

  # GET /designers/1
  # GET /designers/1.json
  def show
    @designer = Designer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @designer }
    end
  end

  # GET /designers/new
  # GET /designers/new.json
  def new
    @designer = Designer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @designer }
    end
  end

  # GET /designers/1/edit
  def edit
    @designer = Designer.find(params[:id])
  end

  # POST /designers
  # POST /designers.json
  def create
    @designer = Designer.new#(params[:designer])

    @designer.first_name = params[:designer][:first_name]
    @designer.last_name = params[:designer][:last_name]
    @designer.biography = params[:designer][:biography]


    # retrieve image extension
    extension = params[:designer][:photo].original_filename.split('.').last

    # create a tmp file
    id = 0
    images_path = Rails.root.join('app', 'assets', 'images')
    img_name = "designer-#{id.to_s}"

    while File.exist?(File.join(images_path, "#{img_name}.#{extension}")) do
      id += 1
      img_name = "designer-#{id.to_s}"
    end

    # create a new image
    image = Image.new
    image.name = img_name
    image.extension = extension

    # create association between designer and its image
    @designer.image = image

    # save to temp file
    File.open(File.join(images_path, "#{img_name}.#{extension}"), 'wb') do |f|
      f.write params[:designer][:photo].read
    end

    respond_to do |format|
      if @designer.save
        format.html { redirect_to @designer, notice: 'Designer was successfully created.' }
        format.json { render json: @designer, status: :created, location: @designer }
      else
        format.html { render action: "new" }
        format.json { render json: @designer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /designers/1
  # PUT /designers/1.json
  def update
    @designer = Designer.find(params[:id])

    respond_to do |format|
      if @designer.update_attributes(params[:designer])
        format.html { redirect_to @designer, notice: 'Designer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @designer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /designers/1
  # DELETE /designers/1.json
  def destroy
    @designer = Designer.find(params[:id])
    @designer.destroy

    respond_to do |format|
      format.html { redirect_to designers_url }
      format.json { head :no_content }
    end
  end

  # DESIGNED /designers/1/designed
  def designed
    @designer = Designer.find(params[:id])
    #@products = @designer.products

    respond_to do |format|
      format.html # designed.html.erb
    end
  end
end
