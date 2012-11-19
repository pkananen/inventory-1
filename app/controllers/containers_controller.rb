class ContainersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :set_locale

   def set_locale
     if !current_user.nil?
       I18n.locale = current_user.locale
     else
       config.i18n.default_locale = :eu
     end
   end
  

  def index
    @containers = current_user.containers.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @containers }
    end
  end

  def show
    @container = current_user.containers.find(params[:id])
    @levels = @container.levels
    @itemable = @container
    
    if params[:category_id]
    @items = @itemable.items.where(:category_id => params[:category_id])
    else
    @items = @itemable.items.order('category_id DESC')
    end
    
    @box = Container.find(params[:id])
     level_ids = %(SELECT id FROM levels WHERE container_id = :container_id)
     compartment_ids = %(SELECT id FROM compartments WHERE level_id IN (#{level_ids}))
     #compartment_ids = @box.compartment_ids

     @category_items = Item.includes(:category).where("(itemable_type = 'Container' AND itemable_id = :container_id) OR (itemable_type = 'Level' AND itemable_id IN (#{level_ids})) OR (itemable_type = 'Compartment' AND itemable_id IN (#{compartment_ids}))", :container_id => @box.id).group("categories.name").sum("quantity * value")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @container }
    end
  end

  def new
    @container = current_user.containers.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @container }
    end
  end

  def edit
    @container = current_user.containers.find(params[:id])
  end

  def create
    @container = current_user.containers.new(params[:container])
    #@container.user_id = current_user.id

    respond_to do |format|
      if @container.save
        format.html { redirect_to @container, notice: 'Container was successfully created.' }
        format.json { render json: @container, status: :created, location: @container }
      else
        format.html { render action: "new" }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /containers/1
  # PUT /containers/1.json
  def update
    @container = Container.find(params[:id])

    respond_to do |format|
      if @container.update_attributes(params[:container])
        format.html { redirect_to @container, notice: 'Container was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /containers/1
  # DELETE /containers/1.json
  def destroy
    @container = Container.find(params[:id])
    @container.destroy

    respond_to do |format|
      format.html { redirect_to containers_url, notice: 'Container was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
