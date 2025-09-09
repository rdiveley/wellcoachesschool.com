$(document).ready(function () {
  // Modern initialization with better error handling
  console.log('Wellcoaches Audio Library - Initializing...');

  // Debug form existence immediately
  console.log(
    'Form found:',
    $('form[name="WellcoachesMemberClassesAdd"]').length
  );
  console.log('Add button found:', $('#AddNew').length);
  console.log(
    'Form action:',
    $('form[name="WellcoachesMemberClassesAdd"]').attr('action')
  );

  // Initialize all components
  initSortableTable();
  initDatePickers();
  initModals();
  initEditMode();
  initDeleteFunctionality();
  initArchiveFunctionality();
  initFormValidation();
  initResponsiveHandling();

  // Sortable table functionality
  function initSortableTable() {
    // Add sortable class and click handlers to table headers
    $('thead th').each(function (index) {
      const $th = $(this);
      // Skip action column (last column)
      if (
        index < $th.parent().children().length - 1 &&
        !$th.text().includes('Actions')
      ) {
        $th.addClass('sortable');
        $th.attr('data-column', index);
        $th.css('cursor', 'pointer');

        // Add sort icons
        if (!$th.find('.sort-icon').length) {
          $th.append(
            ' <span class="sort-icon"><i class="fas fa-sort"></i></span>'
          );
        }

        $th.off('click').on('click', function () {
          const column = $(this).data('column');
          const currentSort = $(this).hasClass('sort-asc')
            ? 'asc'
            : $(this).hasClass('sort-desc')
            ? 'desc'
            : 'none';

          // Remove sorting from all columns
          $('thead th').removeClass('sort-asc sort-desc');
          $('thead th .sort-icon i')
            .removeClass('fa-sort-up fa-sort-down')
            .addClass('fa-sort');

          // Determine new sort direction
          let newSort;
          if (currentSort === 'none' || currentSort === 'desc') {
            newSort = 'asc';
            $(this).addClass('sort-asc');
            $(this)
              .find('.sort-icon i')
              .removeClass('fa-sort fa-sort-down')
              .addClass('fa-sort-up');
          } else {
            newSort = 'desc';
            $(this).addClass('sort-desc');
            $(this)
              .find('.sort-icon i')
              .removeClass('fa-sort fa-sort-up')
              .addClass('fa-sort-down');
          }

          sortTable(column, newSort);
        });
      }
    });
  }

  function sortTable(column, direction) {
    const $tbody = $('tbody');
    const $rows = $tbody.find('tr').filter('[id^="show_row_"]');

    if ($rows.length === 0) {
      console.warn('No rows found to sort');
      return;
    }

    const rowsArray = $rows.toArray();

    rowsArray.sort(function (a, b) {
      const aCell = $(a).find('td').eq(column);
      const bCell = $(b).find('td').eq(column);

      let aVal = aCell.text().trim();
      let bVal = bCell.text().trim();

      // Handle different data types
      const dateRegex = /^\w{3} \d{1,2}, \d{4}$/; // Updated for "Jan 15, 2024" format
      if (dateRegex.test(aVal) && dateRegex.test(bVal)) {
        aVal = new Date(aVal);
        bVal = new Date(bVal);
      } else if (!isNaN(parseFloat(aVal)) && !isNaN(parseFloat(bVal))) {
        aVal = parseFloat(aVal);
        bVal = parseFloat(bVal);
      } else {
        aVal = aVal.toLowerCase();
        bVal = bVal.toLowerCase();
      }

      if (aVal < bVal) {
        return direction === 'asc' ? -1 : 1;
      }
      if (aVal > bVal) {
        return direction === 'asc' ? 1 : -1;
      }
      return 0;
    });

    // Clear tbody and re-append sorted rows
    $tbody.empty();

    rowsArray.forEach(function (row) {
      const $row = $(row);
      const rowId = $row.attr('id');
      const elementId = rowId.replace('show_row_', '');

      $tbody.append($row);

      const $editRow = $('[id="edit_row_' + elementId + '"]');
      if ($editRow.length) {
        $tbody.append($editRow);
      }
    });

    // Add animation
    $tbody.css('opacity', '0.7');
    setTimeout(function () {
      $tbody.animate({ opacity: 1 }, 300);
    }, 100);
  }

  // Initialize date pickers
  function initDatePickers() {
    $('.datePicker, .datepicker').datepicker({
      dateFormat: 'mm/dd/yy',
      changeMonth: true,
      changeYear: true,
      yearRange: '-10:+2',
    });
  }

  // Initialize modals
  function initModals() {
    // Handle description links with proper event delegation
    $(document)
      .off('click', '.description-link')
      .on('click', '.description-link', function (e) {
        e.preventDefault();
        const description = $(this).data('description');

        if (description) {
          $('#courseModal .modal-body .description-content').html(description);
          const modal = new bootstrap.Modal(
            document.getElementById('courseModal')
          );
          modal.show();
        } else {
          console.warn('No description data found');
        }
      });

    // Legacy modal support
    $('.descript')
      .off('click')
      .on('click', function (e) {
        e.preventDefault();
        const description = $(this).data('description');
        if (description) {
          $('#myModal .modal-body').text(description);
          const modal = new bootstrap.Modal(document.getElementById('myModal'));
          modal.show();
        }
      });
  }

  // Initialize edit mode functionality
  function initEditMode() {
    // Edit button click handler with event delegation
    $(document)
      .off('click', 'input[id^="edit_"]')
      .on('click', 'input[id^="edit_"]', function (e) {
        e.preventDefault();
        const element_id = this.id.split('_')[1];

        console.log('Edit clicked for ID:', element_id);

        // Hide show row and display edit row
        $('#show_row_' + element_id).hide();
        $('#edit_row_' + element_id).show();

        // Re-initialize datepickers for the edit form
        $('#edit_row_' + element_id + ' .datepicker').datepicker({
          dateFormat: 'mm/dd/yy',
          changeMonth: true,
          changeYear: true,
          yearRange: '-10:+2',
        });

        // Add visual feedback
        $(this).addClass('loading');
        setTimeout(() => {
          $(this).removeClass('loading');
        }, 500);
      });

    // Cancel button click handler
    $(document)
      .off('click', 'input[id^="cancel_"]')
      .on('click', 'input[id^="cancel_"]', function (e) {
        e.preventDefault();
        const element_id = this.id.split('_')[1];

        console.log('Cancel clicked for ID:', element_id);

        $('#show_row_' + element_id).show();
        $('#edit_row_' + element_id).hide();
      });

    // Save button click handler
    $(document)
      .off('click', 'input[id^="save_"]')
      .on('click', 'input[id^="save_"]', function (e) {
        e.preventDefault();
        const element_id = this.id.split('_')[1];

        console.log('Save clicked for ID:', element_id);

        saveRecord(element_id, $(this));
      });
  }

  // Save record function - FIXED: Removed cceh parameter
  function saveRecord(element_id, saveBtn) {
    let errors = 0;

    // Get form values with proper selectors
    const category = $('#category_' + element_id).val();
    const classTitle = $('#classTitle_' + element_id).val();
    const ce_requirements = $('#ce_requirements_' + element_id).val();
    const downloadLink = $('#downloadLink_' + element_id).val();
    const course_description = $('#course_description_' + element_id).val();
    const nbhwc_expiration = $('#nbhwc_expiration_' + element_id).val() || '';
    const facilitator = $('#facilitator_' + element_id).val();
    const handoutLink = $('#handoutLink_' + element_id).val();
    const classDate = $('#classDate_' + element_id).val();

    // Boolean values
    const cip = $('#cip_' + element_id).is(':checked') ? 1 : 0;
    const wcm = $('#wcm_' + element_id).is(':checked') ? 1 : 0;
    const nchec = $('#nchec_' + element_id).is(':checked') ? 1 : 0;
    const ace = $('#ace_' + element_id).is(':checked') ? 1 : 0;
    const acsm = $('#acsm_' + element_id).is(':checked') ? 1 : 0;
    const boc = $('#boc_' + element_id).is(':checked') ? 1 : 0;
    const cdr = $('#cdr_' + element_id).is(':checked') ? 1 : 0;
    const ichwc = $('#ichwc_' + element_id).is(':checked') ? 1 : 0;
    const archive = $('#archive_' + element_id).is(':checked') ? 1 : 0;

    // Clear previous errors
    $('#edit_category_' + element_id).html('');

    // Validation
    if ($.trim(category) === '') {
      $('#edit_category_' + element_id).html('Please enter a category name');
      errors = 1;
    }

    if (!errors) {
      // Show loading state
      const originalText = saveBtn.val();
      saveBtn.val('Saving...').prop('disabled', true).addClass('loading');

      // Data to send - cceh parameter removed
      const dataToSend = {
        element_id: element_id,
        category: category,
        classTitle: classTitle,
        ce_requirements: ce_requirements,
        downloadLink: downloadLink,
        course_description: course_description,
        nbhwc_expiration: nbhwc_expiration,
        facilitator: facilitator,
        handoutLink: handoutLink,
        classDate: classDate,
        cip: cip,
        wcm: wcm,
        nchec: nchec,
        ace: ace,
        acsm: acsm,
        boc: boc,
        cdr: cdr,
        ichwc: ichwc,
        archive: archive,
      };

      console.log('Sending data:', dataToSend);

      $.ajax({
        type: 'POST',
        url: '/utilities/infusionsoft/automation/audioFileSubmit.cfc?method=updateMemberClasses',
        dataType: 'json',
        data: dataToSend,
        success: function (resp) {
          console.log('Update success', resp);

          // Show success message briefly before reload
          saveBtn.val('Saved!').removeClass('loading').addClass('btn-success');

          setTimeout(() => {
            location.reload();
          }, 1000);
        },
        error: function (xhr, status, error) {
          console.error('Update error:', {
            status: status,
            error: error,
            responseText: xhr.responseText,
            statusCode: xhr.status,
          });

          let errorMessage = 'Error updating record: ' + error;
          if (xhr.responseText) {
            try {
              const errorData = JSON.parse(xhr.responseText);
              if (errorData.message) {
                errorMessage = errorData.message;
              }
            } catch (e) {
              // If it's not JSON, use the raw response
              errorMessage = 'Error: ' + xhr.responseText;
            }
          }

          alert(errorMessage);
          saveBtn
            .val(originalText)
            .prop('disabled', false)
            .removeClass('loading');
        },
      });
    }
  }

  // Initialize delete functionality
  function initDeleteFunctionality() {
    $(document)
      .off('click', 'input[id^="delete_"]')
      .on('click', 'input[id^="delete_"]', function (e) {
        e.preventDefault();
        const element_id = this.id.split('_')[1];

        console.log('Delete clicked for ID:', element_id);

        if (
          !confirm(
            'Are you sure you want to delete this record? This action cannot be undone.'
          )
        ) {
          return;
        }

        const deleteBtn = $(this);
        const originalText = deleteBtn.val();
        deleteBtn.val('Deleting...').prop('disabled', true).addClass('loading');

        $.ajax({
          type: 'POST',
          url: '/utilities/infusionsoft/automation/audioFileSubmit.cfc?method=deleteMemberClasses',
          dataType: 'json',
          data: { element_id: element_id },
          success: function (resp) {
            console.log('Delete success', resp);

            deleteBtn
              .val('Deleted!')
              .removeClass('loading')
              .addClass('btn-success');

            // Fade out and remove rows
            $('#show_row_' + element_id).fadeOut(300, function () {
              $(this).remove();
            });
            $('#edit_row_' + element_id).fadeOut(300, function () {
              $(this).remove();
            });
          },
          error: function (xhr, status, error) {
            console.error('Delete error:', {
              status: status,
              error: error,
              responseText: xhr.responseText,
              statusCode: xhr.status,
            });

            let errorMessage = 'Error deleting record: ' + error;
            if (xhr.responseText) {
              errorMessage = 'Delete failed: ' + xhr.responseText;
            }

            alert(errorMessage);
            deleteBtn
              .val(originalText)
              .prop('disabled', false)
              .removeClass('loading');
          },
        });
      });
  }

  // Initialize archive functionality
  function initArchiveFunctionality() {
    $(document)
      .off('change', 'input[id^="archive_"]')
      .on('change', 'input[id^="archive_"]', function () {
        const element_id = this.id.split('_')[1];
        const isChecked = $(this).is(':checked');
        const archiveValue = isChecked ? 1 : 0;
        const label = $('label[for="archive_' + element_id + '"]');
        const checkbox = $(this);

        // Check if we're on the archived page or unarchived page
        const urlParams = new URLSearchParams(window.location.search);
        const isArchivedPage = urlParams.get('archive') === '1';

        console.log(
          'Archive status changed for ID:',
          element_id,
          'Value:',
          archiveValue,
          'Is archived page:',
          isArchivedPage
        );

        // Update label immediately
        label.text(isChecked ? 'Unarchive' : 'Archive');

        $.ajax({
          type: 'POST',
          url: '/utilities/infusionsoft/automation/audioFileSubmit.cfc?method=updateArchive',
          data: { element_id: element_id, archive: archiveValue },
          success: function (response) {
            console.log('Archive status updated successfully', response);

            // Determine if row should be removed from current view
            let shouldRemoveRow = false;

            if (isArchivedPage && !isChecked) {
              // On archived page, unarchiving an item - should disappear
              shouldRemoveRow = true;
              console.log('Removing row: unarchived item on archived page');
            } else if (!isArchivedPage && isChecked) {
              // On unarchived page, archiving an item - should disappear
              shouldRemoveRow = true;
              console.log('Removing row: archived item on unarchived page');
            }

            if (shouldRemoveRow) {
              $('#show_row_' + element_id).fadeOut(500, function () {
                $(this).remove();
              });
              // Also remove edit row if it exists
              $('#edit_row_' + element_id).fadeOut(500, function () {
                $(this).remove();
              });
            }
          },
          error: function (xhr, status, error) {
            console.error('Archive error:', {
              status: status,
              error: error,
              responseText: xhr.responseText,
              statusCode: xhr.status,
            });

            // Revert the checkbox and label on error
            checkbox.prop('checked', !isChecked);
            label.text(!isChecked ? 'Unarchive' : 'Archive');

            alert('Error updating archive status: ' + error);
          },
        });
      });
  }

  // Initialize form validation - FIXED for Add New functionality
  function initFormValidation() {
    console.log('Initializing form validation...');

    // Make sure we wait for DOM to be fully ready
    setTimeout(function () {
      console.log(
        'Delayed check - Form found:',
        $('form[name="WellcoachesMemberClassesAdd"]').length
      );
      console.log('Delayed check - Add button found:', $('#AddNew').length);

      const form = $('form[name="WellcoachesMemberClassesAdd"]');
      const addBtn = $('#AddNew');

      if (form.length === 0) {
        console.error('Add form not found!');
        return;
      }

      if (addBtn.length === 0) {
        console.error('Add button not found!');
        return;
      }

      // Attach form submit handler
      form.off('submit').on('submit', function (e) {
        console.log('=== FORM SUBMIT TRIGGERED ===');
        let errors = 0;

        // Clear previous errors
        $('.error-message').html('');
        $('#add_category_error').html('');
        $('#add_class_title_error').html('');

        // Get values
        const category = $.trim($('#add_category').val());
        const classTitle = $.trim($('#add_class_title').val());

        console.log('Form values:', { category, classTitle });

        // Validation
        if (category === '') {
          $('#add_category_error').html('Please enter a category name');
          errors = 1;
          console.log('Validation error: Category required');
        }

        if (classTitle === '') {
          $('#add_class_title_error').html('Please enter a Class Title');
          errors = 1;
          console.log('Validation error: Class title required');
        }

        if (errors > 0) {
          console.log('Form validation failed, preventing submit');
          e.preventDefault();
          return false;
        }

        // Show loading state
        // Show loading state
        addBtn.val('Adding...').prop('disabled', true).addClass('loading');

        // Add the AddNew field to ensure ColdFusion processes it
        if (!$('input[name="AddNew"]').length) {
          form.append('<input type="hidden" name="AddNew" value="1">');
        }

        console.log('Form validation passed, allowing submit');
        return true;
      });

      // Attach button click handler as backup
      addBtn.off('click').on('click', function (e) {
        console.log('=== ADD BUTTON CLICKED ===');
        console.log('Button type:', this.type);
        console.log('Button name:', this.name);
        console.log('Button value:', this.value);

        // Let the button trigger form submit naturally
      });
    }, 100);

    // Test function for debugging
    window.testAddForm = function () {
      console.log('=== TESTING ADD FORM ===');
      const form = $('form[name="WellcoachesMemberClassesAdd"]')[0];
      if (form) {
        console.log('Form action:', form.action);
        console.log('Form method:', form.method);
        console.log('Form elements count:', form.elements.length);

        // Fill test data
        $('#add_category').val('Test Category');
        $('#add_class_title').val('Test Title');

        console.log('Test data filled, submitting form...');
        form.submit();
      } else {
        console.error('Form not found!');
      }
    };
  }

  // Initialize responsive handling
  function initResponsiveHandling() {
    function handleResponsiveTable() {
      if ($(window).width() < 768) {
        $('.table-container').addClass('table-responsive');
      } else {
        $('.table-container').removeClass('table-responsive');
      }
    }

    handleResponsiveTable();
    $(window).resize(handleResponsiveTable);
  }

  // Global error handler
  window.addEventListener('error', function (e) {
    console.error('JavaScript Error:', e.error);
  });

  // AJAX error handler
  $(document).ajaxError(function (event, xhr, settings, error) {
    console.error('AJAX Error:', {
      url: settings.url,
      error: error,
      status: xhr.status,
      responseText: xhr.responseText,
    });
  });

  // Re-initialize after dynamic content changes
  $(document).ajaxComplete(function () {
    setTimeout(function () {
      initSortableTable();
      initDatePickers();
    }, 100);
  });

  // Additional utility functions
  function refreshTable() {
    console.log('Refreshing table...');
    location.reload();
  }

  // Make some functions globally available
  window.wellcoachesAudio = {
    refreshTable: refreshTable,
    initSortableTable: initSortableTable,
    initDatePickers: initDatePickers,
  };

  console.log('Wellcoaches Audio Library - Initialization complete');

  // Intercept search form submit
  $('#WCMC').submit(function (e) {
    e.preventDefault(); // stop page reload
	
    var $form = $(this);

    $.post($form.attr('action'), $form.serialize(), function (data) {
      // Replace only the #results section from the new page
		var newResults = $(data).find('#results').html();
		var newStats = $(data).find('#stats').html();
		$('#results').html(newResults);
		$('#stats').html(newStats);
		bindTableEvents();
    }).fail(function (xhr, status, error) {
      alert('Error loading search results: ' + error);
    });
  });
	
	
});
