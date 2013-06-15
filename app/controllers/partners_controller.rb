class PartnersController < ApplicationController
  # GET /partners
  # GET /partners.json
  def index
    @partners = Partner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @partners }
    end
  end

  # GET /partners/1
  # GET /partners/1.json
  def show
    @partner = Partner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @partner }
    end
  end

  # Showing partners
  def all_partners
    @partners = Partner.all

    @related = About.all

    respond_to do |format|
      format.html #all_partners.html.erb
    end
  end

  # GET /partners/new
  # GET /partners/new.json
  def new
    @partner = Partner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @partner }
    end
  end

  # GET /partners/1/edit
  def edit
    @partner = Partner.find(params[:id])
  end

  # POST /partners
  # POST /partners.json
  def create
    @partner = Partner.new#(params[:partner])

    @partner.name = params[:partner][:name]


    # retrieve image extension
    extension = params[:partner][:logo].original_filename.split('.').last

    # create a tmp file
    id = 0
    images_path = Rails.root.join('app', 'assets', 'images')
    img_name = "partner_logo-#{id.to_s}"

    while File.exist?(File.join(images_path, "#{img_name}.#{extension}")) do
      id += 1
      img_name = "partner_logo-#{id.to_s}"
    end

    # create a new image
    image = Image.new
    image.name = img_name
    image.extension = extension

    # create association between designer and its image
    @partner.image = image

    # save to temp file
    File.open(File.join(images_path, "#{img_name}.#{extension}"), 'wb') do |f|
      f.write params[:partner][:logo].read
    end

    respond_to do |format|
      if @partner.save
        format.html { redirect_to @partner, notice: 'Partner was successfully created.' }
        format.json { render json: @partner, status: :created, location: @partner }
      else
        format.html { render action: "new" }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /partners/1
  # PUT /partners/1.json
  def update
    @partner = Partner.find(params[:id])

    respond_to do |format|
      if @partner.update_attributes(params[:partner])
        format.html { redirect_to @partner, notice: 'Partner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partners/1
  # DELETE /partners/1.json
  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy

    respond_to do |format|
      format.html { redirect_to partners_url }
      format.json { head :no_content }
    end
  end
end
