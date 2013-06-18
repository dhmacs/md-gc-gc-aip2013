class AboutsController < ApplicationController
  # GET /abouts
  # GET /abouts.json
  def index
    @abouts = About.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @abouts }
    end
  end

  # GET /abouts/1
  # GET /abouts/1.json
  def show
    @about = About.find(params[:id])

    @other = About.all.select {|item| item.id != @about.id}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @about }
    end
  end

  # GET /abouts/new
  # GET /abouts/new.json
  def new
    @about = About.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @about }
    end
  end

  # GET /abouts/1/edit
  def edit
    @about = About.find(params[:id])
  end

  # POST /abouts
  # POST /abouts.json
  def create
    @about = About.new#(params[:about])

    @about.title = params[:about][:title]
    @about.description = params[:about][:description]


    ### FIRST IMAGE ###

    # retrieve image extension
    extension = params[:about][:photo].original_filename.split('.').last

    # create a tmp file
    id = 0
    images_path = Rails.root.join('app', 'assets', 'images')
    img_name = "#{@about.title}-#{id.to_s}"

    while File.exist?(File.join(images_path, "#{img_name}.#{extension}")) do
      id += 1
      img_name = "#{@about.title}-#{id.to_s}"
    end

    # create a new image
    image = Image.new
    image.name = img_name
    image.extension = extension

    # create association between designer and its image
    @about.images << image

    # save to temp file
    File.open(File.join(images_path, "#{img_name}.#{extension}"), 'wb') do |f|
      f.write params[:about][:photo].read
    end


    ### SECOND IMAGE ###

    # retrieve image extension
    extension = params[:about][:photo2].original_filename.split('.').last

    # create a tmp file
    id = 0
    images_path = Rails.root.join('app', 'assets', 'images')
    img_name = "#{@about.title}-#{id.to_s}"

    while File.exist?(File.join(images_path, "#{img_name}.#{extension}")) do
      id += 1
      img_name = "#{@about.title}-#{id.to_s}"
    end

    # create a new image
    image = Image.new
    image.name = img_name
    image.extension = extension

    # create association between designer and its image
    @about.images << image

    # save to temp file
    File.open(File.join(images_path, "#{img_name}.#{extension}"), 'wb') do |f|
      f.write params[:about][:photo2].read
    end

    respond_to do |format|
      if @about.save
        format.html { redirect_to @about, notice: 'About was successfully created.' }
        format.json { render json: @about, status: :created, location: @about }
      else
        format.html { render action: 'new' }
        format.json { render json: @about.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /abouts/1
  # PUT /abouts/1.json
  def update
    @about = About.find(params[:id])

    if params[:about][:title]
      @about.title = params[:about][:title]
    end

    if params[:about][:description]
      @about.description = params[:about][:description]
    end

    respond_to do |format|
      format.html { redirect_to @about, notice: 'About was successfully updated.' }
      format.json { head :no_content }
    end
  end

  # DELETE /abouts/1
  # DELETE /abouts/1.json
  def destroy
    @about = About.find(params[:id])
    @about.destroy

    respond_to do |format|
      format.html { redirect_to abouts_url }
      format.json { head :no_content }
    end
  end
end
