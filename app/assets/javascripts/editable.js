$.fn.editable = function() {
  var old_value = "";

  $(this).attr("contenteditable", "");
  $(this).addClass("editing");

  // dropdown?
  if ($(this).data("editable-datatype") === "single") {
    $(this).editable_association();
  }

  this.focus(function() {
    if (!$(this).data("editable-editing")) {
      // mark active
      $(this).data("editable-editing", true);

      // insert raw input if display_with
      if ($(this).data("editable-display-with")) {
        old_value = $(this).html();
        $(this).html($(this).data("editable-value"));
      }
    }

  }).blur(function() {

    if ($(this).data("editable-datatype") === "single") {
      return;
    }
    // set not-editing
    $(this).data("editable-editing", false);

    // collect info
    var url = $(this).data("editable-url");
    var model = $(this).data("editable-model");
    var id = $(this).data("editable-id");
    var method = $(this).data("editable-method");
    var value = $(this).html().trim();
    var dataType = $(this).data("editable-datatype");
    var display_with = $(this).data("editable-display-with");

    if (validate_editable(value, dataType)) {
      $(this).attr("data-editable-invalid", false);
    } else {
      $(this).attr("data-editable-invalid", true);
      return;
    }

    // send
    $.ajax({
      type: "PATCH",
      url: url,
      context: this,
      contentType: "application/json; charset=utf-8",
      data: '{"'+model+'":{"'+method+'":"'+value+'"},"id":"'+id+'"}',
      dataType: 'json',
    }).done(function(data) {
      // set vars
      $("[data-editable="+$(this).data("editable")+"]").html(data.value);
      $("[data-editable="+$(this).data("editable")+"]").data("editable-value", value);
    });
  });

  function validate_editable(value, dataType) {
    if (dataType == "decimal") {
      return jQuery.isNumeric(value);
    } else {
      return true;
    }
  }

  function stripHTML(dirtyString) {
      var container = document.createElement('div');
      container.innerHTML = dirtyString;
      return container.textContent || container.innerText;
  }

  return this;
}
