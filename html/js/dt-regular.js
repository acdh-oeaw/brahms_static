function createDataTable( tableID, pageLength, start ) {
    var table = $(  '#' + tableID ).DataTable(
        {
            dom: "'<'row controlwrapper'<'col-sm-4'f><'col-sm-4'i><'col-sm-4 exportbuttons'Br>>'" +
                "'<'row'<'col-sm-12't>>'" +
                "'<'row'<'col-sm-6 offset-sm-6'p>>'",
            responsive: true,
            "pageLength": pageLength,
            columnDefs: [{
                targets: 6,
                searchable: true,
                visible: false
            }],
            buttons: [{
                extend: 'copyHtml5',
                text: '<i class="far fa-copy"/>',
                titleAttr: 'Copy',
                className: 'btn-link',
            },
            {
                extend: 'excelHtml5',
                text: '<i class="far fa-file-excel"/>',
                titleAttr: 'Excel',
                className: 'btn-link',
            },
            {
                extend: 'pdfHtml5',
                text: '<i class="far fa-file-pdf"/>',
                titleAttr: 'PDF',
                className: 'btn-link',
            }],
            // order: order,
            orderCellsTop: true,
            fixedHeader: true,
        }
    );
}    