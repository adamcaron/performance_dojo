class ArticlesController < ApplicationController
  def show
    @article = Article.includes(:comments, :taggings).find(params[:id])
  end

  def index
    if params[:tag].blank?
      @tag = nil
    else
      @tag = Tag.find_by_name(params[:tag])
    end
    @articles = Article.paginate(:page => params[:page], :per_page => 9)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was created."
      redirect_to articles_path
    else
      render :new
    end
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    @article = Article.find params[:id]
    if @article.update_attributes(article_params)
      flash[:notice] = "Article was updated."
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    article = Article.find params[:id]
    article.destroy
    flash[:notice] = "#{article} was destroyed."
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :author_id)
  end

end
