$ ->
  # DOMContentLoaded
  recipe_volume = $("span#recipe_volume").text()
  recipe_og = $("span#recipe_og").text()
  console.log("The recipe og from the initial DOM is #{recipe_og}")
  fermentables_table = $("table#fermentables_table tbody")
  hops_table = $("table#hops_table")

  $("button#oz").click ->
    $("input#fermentable_manifest_amount").attr("placeholder","ounces")

  $("button#og").click ->
    $("input#fermentable_manifest_amount").attr("placeholder","pts OG")
  
  $("button#aau").click ->
    $("input#hop_manifest_aau").attr("placeholder","AAUs")
 
  $("button#ibu").click ->
    $("input#hop_manifest_aau").attr("placeholder","IBUs")


  refreshFermentables = () ->
    #empty the table of its current contents
    $("table#fermentables_table tr:first").siblings().remove()

    #get the fermentable manifests from the server and append them to the table
    #
    renderFermentable = (fermentable_manifest)->
      (fermentable) ->
        points_og=oz_to_pts_og(fermentable_manifest.amount,recipe_volume,fermentable.ppg).toFixed(3)
        percent_og=Math.round(points_og / (recipe_og - 1) * 100)
        console.log("The fermentable for #{fermentable_manifest.fermentable_id} is #{fermentable.name}, #{points_og} / #{recipe_og}, which is #{percent_og}%")
        fermentables_table.append("""
        <tr>
          <td><a class=\"remove-fermentable\" href=\"/fermentable_manifests/#{fermentable_manifest.id}\" data-method=\"delete\" data-remote=\"true\" rel=\"nofollow\">remove</a></td>
          <td class=\"ferm-name\">#{fermentable.name}</td>
          <td class=\"ppg\">#{fermentable.ppg}</td>
          <td class=\"amount\">#{fermentable_manifest.amount}</td>
          <td class=\"points_og\">#{points_og}</td>
          <td class=\"percent_og\">#{percent_og}</td>
        </tr>
        """
        )

    $.getJSON($('#recipe-header').data('url')+'/fermentable_manifests', (fermentables) ->
      $.each(fermentables, (index, fermentable_manifest) ->
        $.getJSON("/fermentables/#{fermentable_manifest.fermentable_id}",renderFermentable(fermentable_manifest))
      )
    )

  refreshHops = () ->
    #empty the hops table of its current entries
    $("table#hops_table tr:first").siblings().remove()

    #define a function to render each hop_manifest into a table row.  this will get passed into a $.getJSON call later
    renderHop = (hop_manifest) ->
      (hop) ->
        #'data' is passed in from $.getJSON
        hop_ibu = hop_ibus(hop_manifest.boil_time, recipe_og,recipe_volume, hop_manifest.aau)
        console.log("Adding hop: #{hop.name}, #{hop_manifest.aau} aaus, #{hop_manifest.boil_time}min boil, #{hop_ibu}ibus")
        hops_table.append("""
        <tr>
          <td><a class=\"remove-hop\" href=\"/hop_manifests/#{hop_manifest.id}\" data-method=\"delete\" data-remote=\"true\" rel=\"nofollow\">remove</a></td>
          <td>#{hop.name}</td>
          <td>#{hop_manifest.aau}</td>
          <td>#{hop_manifest.boil_time}</td>
          <td>#{hop_ibu}</td>
        </tr>
          """
        )

    $.getJSON($('#recipe-header').data('url')+'/hop_manifests', (hops) ->
      $.each(hops, (index, hop_manifest) ->
        console.log("getting data for hop id #{hop_manifest.hop_id}")
        $.getJSON("/hops/#{hop_manifest.hop_id}",renderHop(hop_manifest))
      )
    )
    
  refreshRecipeInfo = () ->
    #note that calling .getJSON will route to recipe#show, which will update the OG of the recipe
    console.log("refreshing recipe")
    $.getJSON($('#recipe-header').data('url'), (recipe) ->
      console.log("og is " + recipe.og)
      $("span#recipe_og").text(recipe.og)
      recipe_og=recipe.og
      console.log("fg is " + recipe.fg)
      $("span#recipe_fg").text(recipe.fg)
      recipe_fg=recipe.fg
      console.log("ibu is " + recipe.ibu)
      $("span#recipe_ibu").text(recipe.ibu)
      recipe_ibu=recipe.ibu
      console.log("volume is " + recipe.final_volume)
      $("span#recipe_volume").text(recipe.final_volume)
      recalculateFermentables()
      recalculateHops()
    )

  recalculateFermentables=() ->
    #after a recipe change the OG points and percentages for each fermentable need to be updated
    #the recipe information must be current or some information won't be correctly calculated
    console.log("recalculating fermentable values")
    $("table#fermentables_table tr.fermentable_entry").each ( (index, entry) ->
      entry_oz = $(this).find("td.amount").text()
      entry_ppg = $(this).find("td.ppg").text()
      entry_points_og = oz_to_pts_og(entry_oz,recipe_volume,entry_ppg)
      entry_percent_og =Math.round(entry_points_og / (recipe_og - 1) * 100)
      console.log("#{entry_oz}oz at #{entry_ppg}ppg, #{entry_points_og}pts og / #{recipe_og} making #{entry_percent_og} of total")

      $(this).find("td.points_og").text(entry_points_og)
      $(this).find("td.percent_og").text(entry_percent_og)

    )


  recalculateHops=() ->
    #after a recipe change the IBU numbers for each hop may need to be updated based on new OG, etc
    #the recipe should also be updated to account for a new total IBU number
    total_ibus=0.0
    console.log("recalculating hop ibus")
    $("table#hops_table tr.hop_entry").each ( (index,entry) ->
      entry_aau= $(this).find("td.aau").text()
      entry_boil_time= $(this).find("td.boil_time").text()
      entry_ibu = hop_ibus(entry_boil_time,recipe_og,recipe_volume,entry_aau)
      console.log("Hop with #{entry_aau}aaus for #{entry_boil_time}minutes yielding #{entry_ibu}ibus")
      $(this).find("td.ibu").text(entry_ibu)
      total_ibus += parseFloat(entry_ibu)
    )
    console.log("total ibus #{total_ibus.toFixed(1)}")
    $.ajax(
      type: 'PUT'
      url: $('#recipe-header').data('url')
      data:
        recipe:
          ibu: Math.round(total_ibus)
    )
    recipe_ibu=total_ibus
    $("span#recipe_ibu").text(total_ibus)

    
  $("form#new_fermentable_manifest").submit( (e) ->
    e.preventDefault()
    amount_input = $(this).find("input#fermentable_manifest_amount")
    console.log("input amount is #{amount_input.val()}")
    ferm_id = $(this).find("select#fermentable_manifest_fermentable_id").val()
    # convert the points OG value back into ounces before submitting the form
    # get the fermentable's ppg and add it to the hidden 'ppg' field in the form
    $.getJSON('/fermentables/'+ferm_id,(fermentable) ->
      if $("form#new_fermentable_manifest button#og").hasClass("active")
        console.log("form value is points og")
        fermentable_oz = points_og_to_oz(amount_input.val(),recipe_volume,fermentable.ppg)
      else
        fermentable_oz = amount_input.val()
        console.log("form value is ounces, amount is #{fermentable_oz}")
      $('form.new_fermentable_manifest input#ppg').val(fermentable.ppg)
      $.post('/fermentable_manifests',
        fermentable_manifest:
          fermentable_id:ferm_id
          amount:Math.round(fermentable_oz)
          recipe_id:$("form#new_fermentable_manifest input#fermentable_manifest_recipe_id").val()
        (data) ->
          new_manifest = $.parseJSON(data)
          fermentables_table.append("""
          <tr class =\"fermentable_entry\" id=\"#{new_manifest.id}\" >
            <td><a class=\"remove-fermentable\" href=\"/fermentable_manifests/#{new_manifest.id}\" data-method=\"delete\" data-remote=\"true\" rel=\"nofollow\">remove</a></td>
          <td class=\"ferm-name\">#{fermentable.name}</td>
          <td class=\"ppg\">#{fermentable.ppg}</td>
          <td class=\"amount\">#{fermentable_oz}</td>
          <td class=\"points_og\">  </td>
          <td class=\"percent_og\">  </td>
        </tr>
        """
          )
          refreshRecipeInfo()
      )
    )
  )
  $("a.remove-fermentable").live("click", () ->
    $(this).closest("tr").remove()
    refreshRecipeInfo()
    recalculateFermentables()
  )
  $("a.remove-hop").live("click", () ->
    $(this).closest("tr").remove()
    refreshRecipeInfo()
    recalculateHops()
  )
  
  #----When the page is initially loaded do the stuff below
  refreshRecipeInfo()

  #Helper functions
percentOG = (points, recipe_volume, og) ->
  totalPoints = recipe_volume * (og - 1) * 1000
  points / totalPoints

oz_to_pts_og = (oz, recipe_volume, ppg) ->
  points = oz * ppg / 16
  og= points / 1000 / recipe_volume
  og.toFixed(3)

points_og_to_oz = (og, recipe_volume, ppg) ->
  points = og * 1000 * recipe_volume
  oz = points / ppg * 16

hop_ibus = (boil_time, boil_gravity,boil_volume,hop_aaus) ->
  #first calculate hop utilization by Tinseth
  #U = f(G)xf(T)
  #f(G)= 1.65 * 1.25E-4^(Gb -1) where Gb is the boil gravity
  #f(T)=(1-e^(-0.04*T))/4.15 where T is the boil time in minutes
  fG= 1.65 * Math.pow(0.000125 , (boil_gravity - 1))
  fT= (1 - Math.exp(-0.04 * boil_time))/4.15
  utilization = fG * fT
  console.log("Utilization: #{utilization}")
  ibus= hop_aaus * utilization * 74.89 / boil_volume
  ibus.toFixed(1)




