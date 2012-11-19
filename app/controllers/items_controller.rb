class ItemsController < ApplicationController
  before_filter :load_itemable
  

  def new
    @item = @itemable.items.new
  end
  
  def show
    @item = @itemable.items.find(params[:id])
  end

  def create

    @item = @itemable.items.new(params[:item])
    @item.user_id = current_user.id
    case @item.save
    when @item.itemable_type == "Compartment"
      redirect_to [@itemable.level, @itemable], notice: "item created."
    when @item.itemable_type == "Level"
      redirect_to [@itemable.container, @itemable], notice: "item created."
    else #Container
      redirect_to @itemable, notice: "item created."
    end 
  end
  
  def edit
    @item = @itemable.items.find(params[:id])
  end
  
  def update
      @item = @itemable.items.find(params[:id])

      case @item.update_attributes(params[:item])
      when @item.itemable_type == "Compartment"
        redirect_to [@itemable.level, @itemable], notice: "item updated."
      when @item.itemable_type == "Level"
        redirect_to [@itemable.container, @itemable], notice: "item updated."
      else #Container
        redirect_to @itemable, notice: "item updated."
      end
   end
   
   def destroy
     @item = @itemable.items.find(params[:id])
     
     
     if @item.itemable_type == "Compartment"  
       @item.destroy
       redirect_to [@itemable.level, @itemable], notice: "item deleted."
     elsif @item.itemable_type == "Level"
       @item.destroy
       redirect_to [@itemable.container, @itemable], notice: "item deleted."
     else #Container
       @item.destroy
       redirect_to @itemable, notice: "item deleted."
     end
   end
  
  



private

  #def load_itemable
    #resource, id = request.path.split('/')[1, 2]
    #@itemable = resource.singularize.classify.constantize.find(id)
  #end

  # alternative option:
   def load_itemable
     klass = [Container, Level, Compartment].detect { |c| params["#{c.name.underscore}_id"] }
     @itemable = klass.find(params["#{klass.name.underscore}_id"])
   end
end