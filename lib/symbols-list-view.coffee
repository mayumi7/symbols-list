{SelectListView} = require 'atom-space-pen-views'

module.exports =
    class SymbolsListView extends SelectListView

        items: []
        callOnConfirm: null
        cancelling: true

        initialize: ->

            super

            @addClass('symbols-list')
            @setItems([])

            @filterEditorView.getModel().placeholderText = 'Start typing to filter...'

        viewForItem: (item) ->
            "<li class='full-menu list-tree'>" +
                "<span class='pastille list-item-#{item.type}'></span>" +
                "<span class='list-item'>#{item.label}</span>" +
            "</li>"

        confirmed: (item) ->
            if item.objet? and @callOnConfirm?
                @callOnConfirm( item.range )

        cleanItems: () ->
            @items = []
            @setItems(@items)

        cancel: ->
            @cleanItems()

        getFilterKey: () -> "label"

        addItem: (item) ->
            @items.push(item)
            @setItems(@items)

        sortItems: () ->
            if atom.config.get('symbols-list.basic.alphabeticalSorting')
                @items.sort (a, b) ->
                    a.label.localeCompare(b.label)
            else
                @items.sort (a, b) ->
                    a.range?.start.row - b.range?.start.row

            @setItems(@items)

        getItemList: ->
            return @items

        setItemList: (itemlist) ->
            @setItems(itemlist)

        getTitle: -> atom.config.get('symbols-list.basic.title')

        getURI: -> 'atom://symbols-list'

        getDefaultLocation: -> "right"

        getAllowedLocations: -> ["left", "right"]

        serialize: ->

        destroy: ->
            @element.remove()
