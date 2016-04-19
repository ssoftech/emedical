<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <title>Smart AutoComplete Samples</title>
  <meta http-equiv="content-type" content="text/html; charset=iso-8859-1">

  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery.smart_autocomplete.js"></script>

  <script type="text/javascript" src="js/qs_score.js"></script>

  <script type="text/javascript">
    $(function(){
        //example 1
        $("#basic_autocomplete_field").smartAutoComplete({source: ['Apple', 'Banana', 'Orange', 'Mango']});

        //example 2
        $("#country_field").smartAutoComplete({source: "countries.json", forceSelect: true, maxResults: 5, delay: 200 });

        //example 3
        $("#type_ahead_autocomplete_field").smartAutoComplete({source: ['Apple', 'Banana', 'Orange', 'Mango'], typeAhead: true });

        //example 4
        $("#type_ahead_only_autocomplete_field").smartAutoComplete({source: ['Apple', 'Banana', 'Orange', 'Mango'], typeAhead: true, maxResults: 1, resultsContainer: false });

        var jazz_musicians = [
          "Scott Joplin",
          "Charles Bolden",
          "Duke Ellington",
          "Louis Armstrong",
          "Earl Hines",
          "Fats Waller",
          "Count Basie",
          "Benny Goodman",
          "Sun Ra",
          "Thelonious Monk",
          "Dizzy Gillespie",
          "Charlie Parker",
          "Dave Brubeck",
          "Charles Mingus",
          "Oscar Peterson",
          "Miles Davis",
          "John Coltrane",
          "Chet Baker",
          "Ornette Coleman",
          "Wynton Marsalis",
          "Billie Holiday",
          "Ella Fitzgerald",
          "Sarah Vaughan"
        ];

        //example 5
        $("#jazz_musicians_field").smartAutoComplete({
        source: jazz_musicians,

        filter: function(term, source){
            var filtered_and_sorted_list =  $.map(source, function(item){
                                               var score = item.toLowerCase().score(term.toLowerCase());

                                               if(score > 0)
                                                 return { 'name': item, 'value': score }
                                            }).sort(function(a, b){ return b.value - a.value });

            return $.map(filtered_and_sorted_list, function(item){
              return item.name;
            });
          }

        });

        //example 6
        $("#textarea_autocomplete_field").smartAutoComplete({source: "countries.json", maxResults: 5, delay: 200 } );
        $("#textarea_autocomplete_field").bind({

           keyIn: function(ev){
             var tag_list = ev.smartAutocompleteData.query.split(","); 
             //pass the modified query to default event
             ev.smartAutocompleteData.query = $.trim(tag_list[tag_list.length - 1]);
           },

           itemSelect: function(ev, selected_item){ 
            var options = $(this).smartAutoComplete();

            //get the text from selected item
            var selected_value = $(selected_item).text();
            var cur_list = $(this).val().split(","); 
            cur_list[cur_list.length - 1] = selected_value;
            $(this).val(cur_list.join(",") + ","); 

            //set item selected property
            options.setItemSelected(true);

            //hide results container
            $(this).trigger('lostFocus');
              
            //prevent default event handler from executing
            ev.preventDefault();
          },

        });

        //example 7
        $("#jazz_musicians_with_highlight_field").smartAutoComplete({
          source: jazz_musicians,

          filter: function(term, source){
              var filtered_and_sorted_list =  $.map(source, function(item){
                                                 var score = item.toLowerCase().score(term.toLowerCase());

                                                 if(score > 0)
                                                   return { 'name': item, 'value': score }
                                              }).sort(function(a, b){ return b.value - a.value });

              return $.map(filtered_and_sorted_list, function(item){
                return item.name;
              });
          },

          resultFormatter: function(r){ return ("<li>" + r.replace(new RegExp($(this.context).val(),"gi"), "<strong>$&</strong>") + "</li>"); }

        });

    });
  </script>

  <style>
    /* General styles */
    body { margin: 0; padding: 0; font: 80%/1.5 Arial,Helvetica,sans-serif; color: #111; background-color: #FFF; }
    h2 { margin: 0px; padding: 10px; font-family: Georgia, "Times New Roman", Times, serif; font-size: 200%; font-weight: normal; color: #FFF; background-color: #CCC; border-bottom: #BBB 2px solid; }
    p#copyright { margin: 20px 10px; font-size: 90%; color: #999; }

    /* Form styles - adopted from http://vesess.com/sandbox/form_template.html */
    div.form-container { margin: 10px; padding: 5px; background-color: #FFF; border: #EEE 1px solid; }

    p.legend { margin-bottom: 1em; }
    p.legend em { color: #C00; font-style: normal; }

    div.code_block { margin: 0 0 10px 0; padding: 5px 10px; border: #FC6 1px solid; background-color: #FFC; }
    div.code_block p { margin: 0; }
    div.code_block p em { color: #C00; font-style: normal; font-weight: bold; }

    div.form-container form p { margin: 0; }
    div.form-container form p.note { margin-left: 170px; font-size: 90%; color: #333; }
    div.form-container form fieldset { margin: 10px 0; padding: 10px; border: #DDD 1px solid; }
    div.form-container form legend { font-weight: bold; color: #666; }
    div.form-container form fieldset div { padding: 0.25em 0; }
    div.form-container label, 
    div.form-container span.label { margin-right: 10px; padding-right: 10px; width: 150px; display: block; float: left; text-align: right; position: relative; }
    div.form-container label.error, 
    div.form-container span.error { color: #C00; }
    div.form-container label em, 
    div.form-container span.label em { position: absolute; right: 0; font-size: 120%; font-style: normal; color: #C00; }
    div.form-container input.error { border-color: #C00; background-color: #FEF; }
    div.form-container input:focus,
    div.form-container input.error:focus, 
    div.form-container textarea:focus {	background-color: #FFC; border-color: #FC6; }
    div.form-container div.controlset label, 
    div.form-container div.controlset input { display: inline; float: none; }
    div.form-container div.controlset div { margin-left: 170px; }
    div.form-container div.buttonrow { margin-left: 180px; }

    ul li {list-style: none; cursor: pointer;}
    li.smart_autocomplete_highlight {background-color: #C1CE84;}
    ul { margin: 10px 0; padding: 5px; background-color: #E3EBBC; }
  </style>

</head>

<body>
     
        <h2>Smart AutoComplete Samples</h2>

        <p>Please check the source code of this page to learn how these examples were implemented</p>

       
            <fieldset id="example_1">
              <legend>Example 1</legend>

              <p>Most basic configuration, with source provided as an Array</p>

              <div>
                <label for="basic_autocomplete_field">Favorite Fruit</label>
                <input type="text" autocomplete="off" id="basic_autocomplete_field"/>
              </div>

            </fieldset>

            <fieldset id="example_2">
              <legend>Example 2</legend>

              <p>This widget loads the source list via AJAX from the given URL as the source. Also, <em>forceSelect</em> option is enforced, <em>maxResults</em> is set to 5 and there's a <em>delay</em> of 300ms between requests.</p>

              <div>
                <label for="country_field">Country</label>
                <input type="text" autocomplete="off" id="country_field"/>
              </div>

            </fieldset>

            <fieldset id="example_3">
              <legend>Example 3</legend>

              <p>With <em>typeAhead</em> option enabled</p>

              <div>
                <label for="type_ahead_autocomplete_field">Favorite Fruit</label>
                <input type="text" autocomplete="off" id="type_ahead_autocomplete_field"/>
              </div>

            </fieldset>

            <fieldset id="example_4">
               <legend>Example 4</legend>

               <p>Only shows the best matching suggestion in-field using the <em>typeAhead</em> option and <em>resultsContainer</em> is set to <em>false</em>.</p>

               <div>
                 <label for="type_ahead_only_autocomplete_field">Favorite Fruit</label>
                 <input type="text" autocomplete="off" id="type_ahead_only_autocomplete_field"/>
               </div>
            </fieldset>

            <fieldset id="example_5">
              <legend>Example 5</legend>

              <p>In this example, we replace the default filtering algorithm with QuickSilver like filtering algorithm.</p>

              <div>
                <label for="jazz_musicians_field">Favorite Jazz Musician</label>
                <input type="text" autocomplete="off" id="jazz_musicians_field"/>
              </div>
            </fieldset>

           
                   <textarea  rows="3" cols="25" autocomplete="off" id="textarea_autocomplete_field"></textarea>
               

            <fieldset id="example_7">
              <legend>Example 7</legend>

              <p>Clone of Example 5 which highlights matching portion in results (note the use of <em>resultFormatter</em> option).</p>

              <div>
                <label for="jazz_musicians_with_highlight_field">Favorite Jazz Musician</label>
                <input type="text" autocomplete="off" id="jazz_musicians_with_highlight_field"/>
              </div>
            </fieldset>




</body>
</html>

