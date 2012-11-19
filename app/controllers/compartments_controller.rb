class CompartmentsController < ApplicationController

  def show
  
    @level = Level.find(params[:level_id])
    @compartment = @level.compartments.find(params[:id])
    @itemable = @compartment
    if params[:category_id]
    @items = @itemable.items.where(:category_id => params[:category_id])
    else
    @items = @itemable.items.order('category_id DESC')
    end
    @item = Item.new
    @container = @level.container
    @box = Compartment.find(params[:id])
    #@category_items = @items.includes(:category).group("categories.name","items.category_id").sum("quantity * value")
    
      @category_items = Item.includes(:category).where("(itemable_type = 'Compartment' AND itemable_id = :compartment_id)", :compartment_id => @box.id).group("categories.name").sum("quantity * value")
 
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @container }
    end
  end

  
  def new 
    
    @level = Level.find(params[:level_id])
    @compartment =  @level.compartments.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @compartment }
    end
  end

  # GET /compartments/1/edit
  def edit
    @level = Level.find(params[:level_id])
    @compartment = @level.compartments.find(params[:id])
  end
  
 

  # POST /compartments
  # POST /compartments.json
  def create
    @level = Level.find(params[:level_id])
    @compartment = @level.compartments.new(params[:compartment])
    
    


    respond_to do |format|
      if @compartment.save
        format.html { redirect_to ([@level, @compartment]), notice: 'Compartment was successfully created.' }
        format.json { render json: @compartment, status: :created, location: @compartment }
      else
        format.html { render action: "new" }
        format.json { render json: @compartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /compartments/1
  # PUT /compartments/1.json
  def update
    @compartment = Compartment.find(params[:id])
    level = @compartment.level

    respond_to do |format|
      if @compartment.update_attributes(params[:compartment])
        format.html { redirect_to ([level, @compartment]), notice: 'Compartment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @compartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compartments/1
  # DELETE /compartments/1.json
  def destroy
    @compartment = Compartment.find(params[:id])
    @compartment.destroy

    respond_to do |format|
      format.html { redirect_to compartments_url }
      format.json { head :no_content }
    end
  end
end
