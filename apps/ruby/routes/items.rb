# encoding: UTF-8

require 'logger'

get '/todo/api/items' do

    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO

    total = Item.count()
    
    sortFields = params['sortFields']
    sortDirections = params['sortDirections']
    page = Integer(params['page'])
    
    logger.info("creating query object")
    #items = Item.all
    items = Item

    logger.info("add sorting")
    if (sortFields == 'id')
        items = items.order(id: (sortDirections == 'desc') ? :desc : :asc)
    elsif (sortFields == 'description')
        items = items.order(description: (sortDirections == 'desc') ? :desc : :asc)
    elsif (sortFields == 'done')
        items = items.order(done: (sortDirections == 'desc') ? :desc : :asc)
    elsif
        items = items.order(id: :asc)
    end        

    logger.info("add paging")
    page = (page > 0) ? page : 1 
    #XXX no form of paging is working :-(
    #items.page(page).per_page(10)
    items.offset(10 * (page - 1))
    items.limit(10)

    logger.info("building response")
    response = { 
        "currentPage" => page,
        "list" => items,
        "pageSize" => 10,
        "sortDirections" => sortDirections,
        "sortFields" => sortFields,
        "totalResults" => total
    }
    logger.info("returning response")
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


