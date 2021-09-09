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

#   POST /baked_goods
#   creates a new baked good in the database (FAILED - 1)
#   returns data for the newly created baked good as JSON (FAILED - 2)

  post '/baked_goods' do
    # access data in body of request and create info
    baked_good = BakedGood.create(
      name: params[:name],
      price: params[:price],
      bakery_id: params[:bakery_id]
    )
    # send response with new record to JSON
    baked_good.to_json
  end


# PATCH /bakeries/:id
#   updates the name of the bakery in the database (FAILED - 3)
#   returns data for the updated bakery as JSON (FAILED - 4)

  patch '/bakeries/:id' do
    # find the bakery by id
    bakery = Bakery.find(params[:id])
    # access and update in body
    bakery.update(
      name: params[:name]
    )
    # send to json
    bakery.to_json
  end


# DELETE /baked_goods/:id
#   deletes the baked good from the database (FAILED - 5)
  delete '/baked_goods/:id' do
    # find by id
    baked_good = BakedGood.find(params[:id])
    # destroy record
    baked_good.destroy
    # send to json
    baked_good.to_json
  end

end
