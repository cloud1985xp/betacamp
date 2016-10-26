$ ->
  $("[data-toggle] [data-student]").hover () ->
    $(@).addClass('highlight')
    sid = $(@).data('student')
    $('.table').addClass('hovered')
    $(".jt [data-student=#{sid}]").each (i, el) ->
      $(el).addClass('highlight')
      if $(el).data('course')
        cid = $(el).data('course')
        $("[data-course=#{cid}]").not('[data-student]').addClass('highlight')
  , () ->
    $(@).removeClass('highlight')
    $('.table').removeClass('hovered')
    $("[data-student]").removeClass('highlight')
    $("[data-course]").removeClass('highlight')

  $("[data-toggle] [data-course]").hover () ->
    $(@).addClass('highlight')
    cid = $(@).data('course')
    $('.table').addClass('hovered')
    $(".jt [data-course=#{cid}]").each (i, el) ->
      $(el).addClass('highlight')
      if $(el).data('student')
        sid = $(el).data('student')
        console.log sid
        console.log $("[data-student=#{sid}]")
        $("[data-student=#{sid}]").not('[data-course]').addClass('highlight')
  , () ->
    $(@).removeClass('highlight')
    $('.table').removeClass('hovered')
    $("[data-student]").removeClass('highlight')
    $("[data-course]").removeClass('highlight')
