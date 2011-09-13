$(function() {
  $('.new.contextual.button').live('click', function(e) {
    e.preventDefault();

    if ($(this).hasClass('disabled')) {
      return;
    }

    $new = $(this);
    $(this).addClass('disabled');
    $('table.fancy tbody tr').addClass('disabled');
    $('.inner h1')
      .before('<div class="new-context" style="display: none; height: 180px;"><img src="/breeze/images/big-roller.gif" /></div>')
      .parent()
      .find('.new-context')
      .slideDown("normal");

    $.get(this.href, function(data) {
      $('.new-context').html(data).height('auto');
    });
  });

  $('.new-context button.ok').live('click', function(e) {
    $('form.breeze-form').submit();
    e.preventDefault();
  });

  $('.new-context button.cancel').live('click', function(e) {
    closeContextualNew();
    e.preventDefault();
  });

  $('table.contextual .actions a.edit').live('click', function(e) {
    if ($(this).hasClass('disabled')) {
      e.preventDefault();
      return;
    }

    columns = $(this).parents('table.contextual').find('thead tr th').length;
    $('.new.contextual.button').addClass('disabled');

    $(this)
      .addClass('disabled')
      .parents('tr')
      .addClass('active')
      .after('<tr class="edit"><td colspan="' + columns + '"><div class="edit-context" style="display: none; height: 180px;"><img src="/breeze/images/big-roller.gif" /></div></td></tr>')
      .parent()
      .find('.edit-context')
      .slideDown();

    $tr = $(this).parents('tr');
    $('table.fancy tbody tr').not($tr).addClass('disabled');
    $('.new.context.button').fadeOut();
    $.get(this.href, function(data) {
      $('table.fancy tbody tr.edit .edit-context').html(data).height('auto');
    });
    e.preventDefault();
  });

  $('table.contextual tr.edit button.ok').live('click', function(e) {
    $(this).before('<img src="/breeze/images/big-roller.gif" />');
    $('form.breeze-form').submit();
    e.preventDefault();
  });

  $('table.contextual tr.edit button.cancel').live('click', function(e) {
    closeContextualEdit();
    e.preventDefault();
  });

  // $('table.sortable tbody').sortable({
  //   update: function(e, ui) {
  //       $.ajax({
  //         url: '/admin/store/categories/reorder.js',
  //         type: 'post',
  //         data: '_method=put&' + $(this).sortable('serialize')
  //       });
  //     }
  // });

  $('.filters a').live('click', function(e) {
    $.get(this.href);
    e.preventDefault();
  });

  $('.fake-right-sidebar #uploader').each(function() {
    product_id = $(this).parents('.product-edit').attr('id').slice(8);
    script_data = {};
    script_data[$('meta[name=csrf-param]').attr('content')] = $('meta[name=csrf-token]').attr('content');
    script_data[$(this).attr('data-session-key')] = $(this).attr('data-session-id');
    $(this).uploadify({
      uploader:     '/breeze/javascripts/uploadify/uploadify.swf',
      cancelImg:    '/breeze/images/icons/delete.png',
      buttonImg:    '/breeze/images/buttons/upload.png',
      width:        180,
      height:       40,
      multi:        true,
      auto:         true,
      script:       '/admin/store/products/' + product_id + '/product_images',
      scriptData:   script_data,
      fileDataName: 'file',
      wmode:        'transparent',
      folder:       '/', //'<%= @folder || "/" %>',
      fileExt:      '*.jpg;*.jpeg;*.gif;*.png',
      fileDesc:     'Image Files',
          
        
      onComplete: function(event, queue_id, file_obj, response, data) {
            var id = /id="([^"]+)"/.exec(response);
            if (id && id[1]) {
              $('#' + id[1]).remove();
            }
          
            $('#assets .image-assets').append(response);
            // show_or_hide_asset_section_headings();
            return true;
          }
        });
      });
});


  function closeContextualEdit() {
    $('table.contextual tr.edit .edit-context').slideUp("normal", function() {
      $(this).parents('tr.edit').remove();
      $('table.contextual tbody tr').removeClass('active').removeClass('disabled');
      $('.new.contextual.button').removeClass('disabled');
    });
  }

  function closeContextualNew() {
    $('.new-context').slideUp("normal", function() {
      $(this).remove();
      $('table.fancy tbody tr').removeClass('active').removeClass('disabled');
      $('.new.contextual.button').removeClass('disabled');
    });
  }