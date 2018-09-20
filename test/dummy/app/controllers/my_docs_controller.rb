class MyDocsController < ApplicationController
  def index
    @my_docs = MyDoc.all
  end

  def new
    @my_doc = MyDoc.new
  end

  def create
    @my_doc = MyDoc.new(my_doc_params)

    if @my_doc.save
      redirect_to my_docs_path
    else
      render 'new'
    end
  end

  def edit
    @my_doc = MyDoc.find(params[:id])
  end

  def update
    @my_doc = MyDoc.find(params[:id])

    if @my_doc.update_attributes(my_doc_params)
      redirect_to my_docs_path
    else
      render 'edit'
    end
  end

  def destroy
    @my_doc = MyDoc.find(params[:id])
    @my_doc.destroy!
    redirect_to my_docs_path
  end

  private

  def my_doc_params
    params.require(:my_doc).permit!
  end
end
