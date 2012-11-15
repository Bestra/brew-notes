$ ->
  # DOMContentLoaded
  $("tr.fermentable_entry").each (index,element) ->
    ppg = $(element).find(".ppg").text()
    amount = $(element).find(".amount").text()
    volume = $("span#volume").text()
    points_og = pointsOG(amount,volume,ppg)
    $(element).find(".points_og").text(points_og.toFixed(3))
    og = $("span#og").text()
    $(element).find(".percent_og").text(Math.round(points_og / (og - 1) * 100))

  $("button#oz").click ->
    $("input#fermentable_manifest_amount").attr("placeholder","ounces")

  $("button#og").click ->
    $("input#fermentable_manifest_amount").attr("placeholder","pts OG")
  
  $("button#aau").click ->
    $("input#hop_manifest_aau").attr("placeholder","AAUs")
 
  $("button#ibu").click ->
    $("input#hop_manifest_aau").attr("placeholder","IBUs")


calculatePoints = (amount,ppg) ->
  amount * ppg / 16

percentOG = (points, volume, og) ->
  totalPoints = volume * (og - 1) * 1000
  points / totalPoints

pointsOG = (oz, volume, ppg) ->
  points = oz * ppg / 16
  og= points / 1000 / volume




  
