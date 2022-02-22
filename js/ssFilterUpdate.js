function updateFilters() {
    var legend = $( ".ssDateFilters fieldset legend" );
    legend.each( function ( item ) {
        var $this = $( this );
        $("#ssForm").find("#ac-panel").after(
            getFieldset( $this )
        );
        $this.remove();
        // var text = getLegendText( $this );
        // $this.text("");
        // $this.append( `<div class="ltext">${text}</div>` );
        // var svg =  `<div class="lsvg"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down" viewBox="0 0 16 16">
        //                 <path d="M3.204 5h9.592L8 10.481 3.204 5zm-.753.659 4.796 5.48a1 1 0 0 0 1.506 0l4.796-5.48c.566-.647.106-1.659-.753-1.659H3.204a1 1 0 0 0-.753 1.659z"/>
        //             </svg></div>`;
        // $this.append( svg );
        // var span = getFieldsetspan( $this );
        // span.css( "display", "none" );
        // $this.click( function() {
        //     if ( span.hasClass( "selected" ) ) {
        //         span.css( "display", "none" );
        //         // ul.css( "max-height", "100%" );
        //         span.removeClass( "selected" );
        //     } else {
        //         span.css( "display", "inline-block" );
        //         span.addClass( "selected" );
        //     }
        // });
    });
    var legend = $( ".ssDescFilters fieldset legend" );
    legend.each( function( index ) {
        if ( index != 0 ) {
            // console.log( index );
            var $this = $( this );
            $this.addClass("fade ssDropdownFilter");
            var text = getLegendText( $this );
            $this.text("");
            $this.append( `<div class="ltext">${text}</div>` );
            var svg =  `<div class="lsvg"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down" viewBox="0 0 16 16">
                            <path d="M3.204 5h9.592L8 10.481 3.204 5zm-.753.659 4.796 5.48a1 1 0 0 0 1.506 0l4.796-5.48c.566-.647.106-1.659-.753-1.659H3.204a1 1 0 0 0-.753 1.659z"/>
                        </svg></div>`;
            $this.append( svg );
            var ul = getFieldsetlist( $this );
            ul.css( "display", "none" );
            $this.click( function() {
                if ( ul.hasClass( "selected" ) ) {
                    ul.css( "display", "none" );
                    // ul.css( "max-height", "100%" );
                    ul.removeClass( "selected" );
                } else {
                    ul.css( "display", "inline-block" );
                    ul.addClass( "selected" );
                }
            });
        } else {
            var $this = $( this );
            // ssForm is a staticSearch id for the html form elements
            $("#ssForm").find("#ac-panel").after(
                getFieldset( $this )
            );
            $this.remove();
        }
    });
    var clearButton = $("#ssForm .clearButton");
    clearButton.append(`
        <button id="ssShow" onclick="showFilters()">advanced filter</button>
    `)
}

$("#ssDoSearch, #ssDoSearch2").click( function() {
    setTimeout(function() {
        var result = $("#ssResults ul li div a");
        result.each( function( item ) {
            $this = $( this );
            var resultUpdate = $this.text();
            // console.log(resultUpdate);
            var update = resultUpdate
            .replace("ssStart", `<div class='ssResultUpdate1'>`)
            .replace("ssEnd", `</div>`)
            .replace("ssStart", `<div class='ssResultUpdate2'>`)
            .replace("ssEnd", `</div>`)
            .replace("ssStart", `<div class='ssResultUpdate3'>`)
            .replace("ssEnd", `</div>`);
            $this.text("");
            $this.append( update );
            // console.log(update);
        });
        
    }, 500);    
});

$( window ).on("load", function() {
    setTimeout(function() {
        var result = $("#ssResults ul li div a");
        result.each( function( item ) {
            $this = $( this );
            var resultUpdate = $this.text();
            // console.log(resultUpdate);
            var update = resultUpdate
            .replace("ssStart", `<div class='ssResultUpdate1'>`)
            .replace("ssEnd", `</div>`)
            .replace("ssStart", `<div class='ssResultUpdate2'>`)
            .replace("ssEnd", `</div>`)
            .replace("ssStart", `<div class='ssResultUpdate3'>`)
            .replace("ssEnd", `</div>`);
            $this.text("");
            $this.append( update );
            // console.log(update);
        });
        
    }, 500);    
});


function getLegendText( input ) {
    var legend = input.text();
    return legend;
}

function getFieldsetlist( input ) {
    var fieldset = input.parent();
    var ul = fieldset.children( "ul" );
    // console.log( ul );
    return ul;
}

function getFieldsetspan( input ) {
    var fieldset = input.parent();
    var span = fieldset.children( "span" );
    // console.log( ul );
    return span;
}

function getFieldset( input ) {
    var fieldset = input.parent();
    fieldset.addClass("simpleFilters");
    return fieldset;
}

function showFilters() {
    var dropdowns = $( ".ssDropdownFilter" );
    if ( dropdowns.hasClass("fade") ) {
        dropdowns
        .removeClass("fade")
        .addClass("active");
    } else {
        dropdowns
        .removeClass("active")
        .addClass("fade");
    }
}