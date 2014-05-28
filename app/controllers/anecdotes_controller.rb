class AnecdotesController < ApplicationController
  def edit
     @anecdote = Anecdote.find(params[:id])
  end
  
  def new
      @chapitre = Chapitre.find(params[:id])
      @anecdote = Anecdote.new
  end
  
  def show
      @anecdote = Anecdote.find(params[:id])
  end

  def destroy
    Anecdote.find(params[:id]).destroy
    flash[:success] = "Anecdote supprimee."
    redirect_to chapters_path
  end

  def create
    @chapitre = Chapitre.find(params[:id])
    @anecdote = @chapitre.anecdotes.new(params[:anecdote])
    if @anecdote.save
      flash[:success] = "Anecdote creee !"
      redirect_to @anecdote
    else
      render 'new'
    end
  end

  def update
    @anecdote = Anecdote.find(params[:id])
    if @anecdote.update_attributes(params[:anecdote])
      flash[:success] = "Anecdote modifiee !"
      redirect_to @anecdote
    else
      render 'edit'
    end
  end
end
