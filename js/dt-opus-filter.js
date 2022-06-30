var _opusSearch = '';
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
 
 
function binAlphabet ( data ) {
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
 
$.fn.dataTable.ext.search.push( function ( settings, searchData ) {
    if ( ! _opusSearch ) {
        return true;
    }
 
    if ( searchData[1] + ' ' +  searchData[2]  === _opusSearch ) {
        return true;
    }
 
    return false;
} );
 
 
function bin ( data1, data2 ) {
    var praefixOpus, bins = {};
 
    for ( var i=0, ien=data1.length ; i<ien ; i++ ) {
        praefixOpus = data1[i] + ' ' + data2[i];
 
        if ( bins[praefixOpus] ) {
            bins[praefixOpus]++;
        }
        else {
            bins[praefixOpus] = 1;
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
            columnDefs: [{
                targets: 4,
                searchable: true,
                visible: false
            }],
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
            "order": [[ 1, "desc" ], [ 2, "asc" ]],
            orderCellsTop: true,
            fixedHeader: true,
        }
    );

    // Opusnumber filter based on second and third column data
 
    var opus = $('<div class="opus"/>').append( 'Filter (Opusnummer): ' );
    var columnData1 = table.column(1).data();
    var columnData2 = table.column(2).data();
    var bins = bin( columnData1, columnData2 );
 
    $('<span class="clear active"/>')
        .data( 'opusnumber', '' )
        .data( 'match-count', columnData1.length )
        .html( 'Alle' )
        .appendTo( opus );

    var praefix = table.column(1).data();
    var opusNo = table.column(2).data();
 
    for ( var i=0 ; i < praefix.length; i++ ) {
        // var letter = String.fromCharCode( 65 + i );
        var praefixOpus = `${praefix[i]} ${opusNo[i]}`;
 
        $('<span/>')
            .data( 'opusnumber', praefixOpus )
            .data( 'match-count', bins[praefixOpus] || 0 )
            //.addClass( ! bins[praefixOpus] ? 'empty' : '' )
            .html( praefixOpus )
            .appendTo( opus );
    }
 
    opus.insertBefore( table.table().container() );
 
    opus.on( 'click', 'span', function () {
        opus.find( '.active' ).removeClass( 'active' );
        $(this).addClass( 'active' );
 
        _opusSearch = $(this).data('opusnumber');
        table.draw();
    } );
 
    var info = $('<div class="opusInfo"></div>')
        .appendTo( opus );
 
    opus
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

    // Alphabet filter based on first columns first char
    
    var alphabet = $('<div class="alphabet"/>').append( 'Filter (alphabetisch): ' );
    var columnData = table.column(0).data();
    var binsA = binAlphabet( columnData );
    
    $('<span class="clear active"/>')
        .data( 'letter', '' )
        .data( 'match-count', columnData.length )
        .html( 'Alle' )
        .appendTo( alphabet );
    
    for ( var i=0 ; i<26 ; i++ ) {
        var letter = String.fromCharCode( 65 + i );
    
        $('<span/>')
            .data( 'letter', letter )
            .data( 'match-count', binsA[letter] || 0 )
            .addClass( ! binsA[letter] ? 'empty' : '' )
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
