class EntriesController < ApplicationController
  before_action :find_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = Entry.all.decorate
  end

  def show
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    if @entry.save
      redirect_to @entry
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    @entry.update_attributes(entry_params)
    if @entry.save
      redirect_to @entry
    else
      redirect_to root_path
    end
  end


  def destroy
    @entry.destroy
    redirect_to entries_path
  end

  private

  def find_entry
    @entry = Entry.find(params[:id]).decorate
  end

  def entry_params
    params.require(:entry).permit(:content)
  end
end
