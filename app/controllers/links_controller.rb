class LinksController < ApplicationController
  before_action :authenticate_user!, except: :redirect

  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    @links = current_user.links.all

    #for example of Class method
    #@links = Link.favorited
  end

  # GET /links/1
  # GET /links/1.jsonfirst_or_create
  def show
  end

  def about
  end

  def redirect
    #raise params[:url] #for debug use
    #raise params.to_yaml show content
    #raise params.inspect
    #raise params.to_json

    short_url = params[:url]
    @link = Link.where(short_url: short_url).first

    if @link.nil?
      raise "Route not found."
      #if redirec to error page
      #remember to return
    end

    @link.increase_count!

    redirect_to @link.original_url, status: 301 #the same as below, which is support after ruby 2.0
    #redirect_to @link.original_url, :status =>301
    #redirect_to original_url
    #redirect_to 'http://www.google.com'
  end

  # GET /links/new
  def new
    @link = current_user.links.new
    @link.short_url = "abc" #Set default in new form
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = current_user.links.new(link_params)

    #@link = current_user.links.where(:original_url[link_params :original_url]).first_or_create()

    #do in model
    #@link = current_user.links.find_or_create_original_url

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = current_user.links.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:original_url, :short_url, :tag_list)
    end
end
