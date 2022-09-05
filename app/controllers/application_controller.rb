class ApplicationController < Sinatra::Base
  set default_content_type: "application/json"
  
  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end
  
  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_goods = BakedGood.by_price
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_good = BakedGood.by_price.first
    baked_good.to_json
  end
  # creates a new baked good in the database
  # returns data for the newly created baked good as JSON
  post '/baked_goods' do
    new_good = BakedGood.create("name":params[:name], "price":params[:price], "bakery_id":params[:bakery_id])
    new_good.to_json
  end
# updates the name of the bakery in the database 
# returns data for the updated bakery as JSON 
  patch '/bakeries/:id' do
    Bakery.update("name":params[:name])
    Bakery.find(params[:id]).to_json
  end
# deletes the baked good from the database
  delete '/baked_goods/:id' do
    BakedGood.find(params[:id]).destroy
  end
end
