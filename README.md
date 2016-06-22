#Guess Price Game

[Project Requirement](https://github.com/tonylibra/GuessPriceGame/blob/master/ProjectTODO.md)

##Structure
`StartGameViewController`: Game introduction and Start Game.  
`GameContainerViewController`: contains and control `UIPageViewController`, navigate next or end game.  
`GameViewController`: The Main Game Area, display the product image and prices  
`GameReviewViewController`: After User finish the game, shows the summary of last game  
`ProductDetailViewController`: an webView can shows the product detail information on Wayfair's website    

##WebService
only one http call based on the catrgory_id, and fetch the json

##Some Simple Description
* use `UIPageViewController` to display every product, use delegate to exchange data between `containerViewController` and `sub GameViewController`
* simple http call with `NSURLSession`. the mix category realized by using every category_id to make a http call, and add them to `dispatch_group`, after all of them finished, disorder the json array.
* 

##Third Party Framework
[SwiftyJson](https://github.com/SwiftyJSON/SwiftyJSON)

