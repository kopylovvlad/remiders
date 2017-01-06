@ItemJS = 
  #logic
  toggle_title_form: (el)->
    if !!el.data("active")
      el.data("active", false)
      this.hide_title_form(el)
    else
      el.data("active", true)
      this.show_title_form(el)

  show_title_form: (el)->
    el.find(".title").hide()
    el.find("span.form").show()

  hide_title_form: (el)->
    el.find(".title").show()
    el.find("span.form").hide()
    el.find("span.form input").val( el.find(".title").html() )

  #inits
  init: ()->
    _that = this
    $(document).on "click", ".edit_item_link", ()->
      _that.toggle_title_form( $(this).parent().parent() )

    $(document).on "change", 'input[name="item[is_done]"]', ()->
      $(this).closest(".simple_form.edit_item").submit()
      

@ItemModalJS = 
  init: ()->
    _that = this
    $(document).on "click", ".item_modal .item_toggle", ()->
      $(this).parent().find(".attribute_body").toggle()
      $(this).parent().find(".attribute_input").toggle()