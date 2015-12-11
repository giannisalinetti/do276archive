# encoding: UTF-8

get '/todo/api/items' do
    items = Item.all
    response = { 
        "currentPage" => 1,
        "list" => items,
        "pageSize" => 10,
        "sortDirections" => "asc",
        "sortFields" => "id",
        "totalResults" => items.size
    }
    return response.to_json
end

get '/todo/api/items/:id' do
    item ||= Item.find(params[:id]) || halt(404)
    return item.to_json
end

post '/todo/api/items' do
    body = JSON.parse request.body.read
    if (body['id'])
    item ||= Item.find(body['id']) || halt(404)
        item.description = body['description']
        item.done = body['done']
        item.save
    else 
        item ||= Item.create(description: body['description'], done: body['done'],) || halt(404)
    end
    return item.to_json
end

delete '/todo/api/items/:id' do
    item ||= Item.find(params[:id]) || halt(404)
    item.destroy
    return item.to_json
end


