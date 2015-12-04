class PaginatedListWrapper(object):
    def __init__(self, current_page, page_size, total_results, sort_fields, sort_directions, list):
        self.current_page = current_page
        self.page_size = page_size
        self.total_results = total_results
        self.sort_fields = sort_fields
        self.sort_directions = sort_directions
        self.list = list
