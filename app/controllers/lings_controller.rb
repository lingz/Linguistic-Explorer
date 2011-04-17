class LingsController < GroupDataController
  helper :groups

  # GET /lings/depth/0-1
  # GET /lings/depth/0-1.xml
  def depth
    @depth = params[:depth].to_i
    @lings = Ling.find_all_by_depth(@depth)

    respond_to do |format|
      format.html # depth.html.erb
      format.xml  { render :xml => [@lings, @depth] }
    end
  end

  # GET /lings
  # GET /lings.xml
  def index
    @lings_by_depth = (0..current_group.depth_maximum).to_a.map{|depth| Ling.find_all_by_depth(depth)}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lings_by_depth }
    end
  end

  # GET /lings/1
  # GET /lings/1.xml
  def show
    @ling = Ling.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ling }
    end
  end

  # GET /lings/1/set_values
  def set_values
    @ling = Ling.find(params[:id])
    @depth = @ling.depth
    @categories = Category.at_depth(@depth)
    @preexisting_values = LingsProperty.find_all_by_ling_id(@ling.id)
  end

  # GET /lings/new
  # GET /lings/new?depth=0-1
  # GET /lings/new.xml
  def new
    @depth = params[:depth].to_i
    @ling = Ling.new(:depth => @depth)
    @parents = @depth ? Ling.find_all_by_depth(@depth - 1) : []

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => [@ling, @lings] }
    end
  end

  # GET /lings/1/edit
  def edit
    @ling = Ling.find(params[:id])
    @depth = @ling.depth
    @parents = @depth ? Ling.find_all_by_depth(@depth - 1) : []
  end

  # POST /lings
  # POST /lings.xml
  def create
    @ling = Ling.new(params[:ling]) do |ling|
      ling.group    = current_group
      ling.creator  = current_user
    end
    @depth = @ling.depth

    respond_to do |format|
      if @ling.save
        format.html { redirect_to([current_group, @ling], :notice => (current_group.ling_name_for_depth(@depth) + ' was successfully created.')) }
        format.xml  { render :xml => @ling, :status => :created, :location => @ling }
      else
        @parents = @depth ? Ling.find_all_by_depth(@depth - 1) : []
        format.html { render :action => "new" }
        format.xml  { render :xml => @ling.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lings/1
  # PUT /lings/1.xml
  def update
    @ling = Ling.find(params[:id])
    @depth = @ling.depth

    respond_to do |format|
      if @ling.update_attributes(params[:ling])
        format.html { redirect_to(group_ling_url(current_group, @ling), :notice => (current_group.ling_name_for_depth(@depth) + ' was successfully updated.') ) }
        format.xml  { head :ok }
      else
        @parents = @depth ? Ling.find_all_by_depth(@depth - 1) : []
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ling.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lings/1
  # DELETE /lings/1.xml
  def destroy
    @ling = Ling.find(params[:id])
    @depth = @ling.depth
    @ling.destroy

    respond_to do |format|
      format.html { redirect_to(group_lings_depth_url(current_group, @depth)) }
      format.xml  { head :ok }
    end
  end
end
