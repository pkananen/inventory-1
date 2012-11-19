class LevelsController < ApplicationController
  
  before_filter :authenticate_user!
  
  
  # GET /containers
  # GET /containers.json
  def index

    
    @containers = current_user.containers.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @containers }
    end
  end
  
  

  def show
    
    @container = Container.find(params[:container_id])
    @level = @container.levels.find(params[:id])
    @itemable = @level
    if params[:category_id]
    @items = @itemable.items.where(:category_id => params[:category_id])
    else
    @items = @itemable.items.order('category_id DESC')
    end
    
    
    @box = Level.find(params[:id])
    compartment_ids = %(SELECT id FROM compartments WHERE level_id = :level_id)
    #compartment_ids = @box.compartment_ids

    @category_items = Item.includes(:category).where("(itemable_type = 'Level' AND itemable_id = :level_id) OR (itemable_type = 'Compartment' AND itemable_id IN (#{compartment_ids}))", :level_id => @box.id).group("categories.name").sum("quantity * value")
    

    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @level }
    end
  end


  def new
    @container = Container.find(params[:container_id])
    @level = @container.levels.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @level }
    end
  end


  def edit
    @container = current_user.containers.find(params[:container_id])
    @level = @container.levels.find(params[:id])
  end
  
 
  def create
    @container = Container.find(params[:container_id])
    @level = @container.levels.new(params[:level])
        

     respond_to do |format|
        if @level.save
          format.html { redirect_to (@container), notice: 'Level was successfully created.' }
          format.json { head :no_content }
        else
          format.html { render action: "new" }
          format.json { render json: @level.errors, status: :unprocessable_entity }
        end
      end
    end
    

  def update
    container = Container.find(params[:container_id])
    @level = container.levels.find(params[:id])
    
    respond_to do |format|
      if @level.update_attributes(params[:level])
        format.html { redirect_to ([@level.container, @level]), notice: 'Level was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @level.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @level = Level.find(params[:id])
    @level.destroy

    respond_to do |format|
      format.html { redirect_to (@level.container) }
      format.json { head :no_content }
    end
  end
end
