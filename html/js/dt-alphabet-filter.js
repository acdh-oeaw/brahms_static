var _alphabetSearch = '';
 
$.fn.dataTable.ext.search.push( function ( settings, searchData ) {
    if ( ! _alphabetSearch ) {
        return true;
    }
 
    if ( searchData[0].charAt(0) === _alphabetSearch ) {
        return true;
    }
 
    return false;
} );
 
 
function bin ( data ) {
    var letter, bins = {};
 
    for ( var i=0, ien=data.length ; i<ien ; i++ ) {
        letter = data[i].charAt(0).toUpperCase();
 
        if ( bins[letter] ) {
            bins[letter]++;
        }
        else {
            bins[letter] = 1;
        }
    }
 
    return bins;
}
    
function createDataTable( tableID ) {
    var table = $(  '#' + tableID ).DataTable(
        {
        
            language: {
            "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/German.json"
        },
            
            dom: "'<'row controlwrapper'<'col-sm-4'f><'col-sm-4'i><'col-sm-4 exportbuttons'Br>>'" +
                "'<'row'<'col-sm-12't>>'" +
                "'<'row'<'col-sm-6 offset-sm-6'p>>'",
            responsive: true,
            pageLength: 15,
            buttons: [{
                extend: 'copyHtml5',
                text: '<i class="far fa-copy"/>',
                titleAttr: 'Copy',
                className: 'btn-link',
                init: function (api, node, config) {
                    $(node).removeClass('btn-secondary')
                }
            },
            {
                extend: 'excelHtml5',
                text: '<i class="far fa-file-excel"/>',
                titleAttr: 'Excel',
                className: 'btn-link',
                init: function (api, node, config) {
                    $(node).removeClass('btn-secondary')
                }
            },
            {
                extend: 'pdfHtml5',
                text: '<i class="far fa-file-pdf"/>',
                titleAttr: 'PDF',
                className: 'btn-link',
                init: function (api, node, config) {
                    $(node).removeClass('btn-secondary')
                }
            }],
            // order: order,
            orderCellsTop: true,
            fixedHeader: true,
        }
    );
 
    var alphabet = $('<div class="alphabet"/>').append( 'Filter: ' );
    var columnData = table.column(0).data();
    var bins = bin( columnData );
 
    $('<span class="clear active"/>')
        .data( 'letter', '' )
        .data( 'match-count', columnData.length )
        .html( 'Alle' )
        .appendTo( alphabet );
 
    for ( var i=0 ; i<26 ; i++ ) {
        var letter = String.fromCharCode( 65 + i );
 
        $('<span/>')
            .data( 'letter', letter )
            .data( 'match-count', bins[letter] || 0 )
            .addClass( ! bins[letter] ? 'empty' : '' )
            .html( letter )
            .appendTo( alphabet );
    }
 
    alphabet.insertBefore( table.table().container() );
 
    alphabet.on( 'click', 'span', function () {
        alphabet.find( '.active' ).removeClass( 'active' );
        $(this).addClass( 'active' );
 
        _alphabetSearch = $(this).data('letter');
        table.draw();
    } );
 
    var info = $('<div class="alphabetInfo"></div>')
        .appendTo( alphabet );
 
    alphabet
        .on( 'mouseenter', 'span', function () {
            info
                .css( {
                    opacity: 1,
                    left: $(this).position().left,
                    width: $(this).width()
                } )
                .html( $(this).data('match-count') );
        } )
        .on( 'mouseleave', 'span', function () {
            info.css('opacity', 0);
        } );
}
