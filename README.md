# food_ndb

Ruby on Rails engine for easing access and use of the USDA National Nutrient Database for Standard Reference.

## Getting started


## Notes
 * Not sure why I started this as a mountable engine -- it's really meant for portions of it to be used directly in your app, while keeping the models, views (mainly handy) partials, controllers, and assets nicely contained.
 * Records are bulk imported from the SR database, to make things speedier. The downside is that the import process may spike to ~2.5GiB RAM needed during import.

## References
 * http://www.ars.usda.gov/Services/docs.htm?docid=8964
 * http://www.fda.gov/Food/GuidanceComplianceRegulatoryInformation/GuidanceDocuments/FoodLabelingNutrition/FoodLabelingGuide/ucm064904.htm

## This is a work in progress!
