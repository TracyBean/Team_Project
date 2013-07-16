# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


events = Event.create([
    { name: 'Boston - Art, Wine & Art Exhibit - Ages 22-45',
      address: '55 Thayer Street, Boston, MA 02118',
      date: 'July 20, 2013',
      time: '19:00',
      description: 'Forget about poking Facebook friends and trading endless texts with that person from OKCupid. Time to add some offline socializing to your calendar!
      
      Check in at 7pm and mingle. Enjoy some delicious cheeses and chocolates as well as an open Champagne, Prosecco & White Wine bar and a private gallery rental for our group. The open bar will be served until 9:30pm.
      
      Light music will be playing, the wine will be flowing and the Gallery will have a featured Art Exhibit perfect for using as a conversation starter.
      
      Now you can meet people face to face before setting up that first date. Remember what that was like?'
    },

    { name: 'R.I.P.D. Opening Night Event',
      address: '175 Tremont St, Boston, MA 02111',
      date: 'July 19, 2013',
      time: '19:00',
      description: 'none'
    },
     { name: 'Getting Coverage: How to Create Constructive Working Relationships with Bloggers & Press',
      address: 'Harvard Innovation Lab
      125 Western Avenue
    Boston, MA 02163',
      date: 'July 16, 2013',
      time: '16:00',
      description: "Scott Kirsner has written for Wired, Fast Company, the New York Times, Variety, and numerous blogs. He also writes the \"Innovation Economy\" blog and column for the Boston Globe, which covers the local startup and venture capital ecosystem. In this interactive workshop, he\'ll share some pro tips on cultivating a constructive relationship with members of the media...and when it makes sense to work with public relations firms...to help you get coverage when your venture launches. Come prepared to do a one-minute or less \"cocktail party\" explainer of what you\'re working on, and get some feedback on honing your pitch when you talk to the media."
}

])
