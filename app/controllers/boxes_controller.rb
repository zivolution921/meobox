class BoxesController < ApplicationController
  before_action :set_plan
  before_action :set_box, except: [:index, :new, :create, :ship]
  before_action :require_admin, except: [:index, :show]
  
  def index
    @boxes = @plan.boxes
  end

  def new    
    @box = @plan.boxes.new
  end

  def create  
    @box = @plan.boxes.new(box_params)  
    puts "inside create box: #{@box.inspect}" 
    if @box.save            
      # puts "PARAMS: #{params.inspect}"
      # array of items attributes
      item_attrs = params[:box][:item_attributes].values 
      # puts "item_attrs: #{item_attrs.inspect}"
      # using custom attribuet writer to create items for the box
      @box.item_attributes = item_attrs
      redirect_to plan_boxes_path(@plan), notice: 'successfully created '
    else
      render 'new'
    end
  end

  def ship
    @box = Box.find(params[:box_id])
    @box.update_attributes(shipped: true)
    redirect_to :back, notice: 'successfully shipped!'
  end

  def show
  end

  def edit
  end

  def update
    if @plan.boxes.create(box_params)
      redirect_to plan_boxes_path(@plan), notice: 'successfully updated '
    else
      render 'edit'
    end
  end

  def destroy
    @plan.boxes.destroy
    redirect_to plan_boxes_path(@plan), notice: 'successfully destroyed'
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def set_box
    @box = Box.find(params[:id])
  end

  def box_params
    params.require(:box).permit(:starts_at, :theme_title, :plan_id)
  end
end
