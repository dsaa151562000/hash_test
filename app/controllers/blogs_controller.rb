class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :update, :destroy]

  # GET /blogs
  def index
    @blogs = Blog.all
    arry = Blog.new.merge_worker(@blogs)
    if params[:order].present?
      sort_by(params, arry)
    else
      @arry = arry
    end


    # binding.pry
    # if params[:order] == "name_desc"
    #   @arry =  arry.sort_by! { |item| item[:name] }.reverse
    # elsif params[:order] == "name_asc"
    #   @arry =  arry.sort_by! { |item| item[:name] }
    # else
    #   @arry =  arry
    # end

    render json: @arry
  end

  # GET /blogs/1
  def show
    render json: @blog
  end

  # POST /blogs
  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      render json: @blog, status: :created, location: @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blogs/1
  def update
    if @blog.update(blog_params)
      render json: @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  def update_list
    @blogs = []
    ActiveRecord::Base.transaction do
      params[:_json].each do |param|
       blog = Blog.find_by(id: param[:id])
        if blog.present?
          blog.update!(title: "タイトル更新", content: "コンテンツ更新2")
          @blogs << blog
        end
      end
    end
    render json: @blogs
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy
  end

  private

    def sort_by(params, arry)
      if params[:order] == "name_desc"
        @arry =  arry.sort_by! { |item| item[:name] }.reverse
      elsif params[:order] == "name_asc"
        @arry =  arry.sort_by! { |item| item[:name] }
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def blog_params
      params.require(:blog).permit(:title, :content)
    end
end
