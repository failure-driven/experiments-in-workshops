class SeedController < ApplicationController
  def index
    Entry.destroy_all
    Entry.create!(
      name: "Darlene",
      text:
        "Cool place, I guess. Might hack it later. Just kidding. Or am " +
        "I? ;) Thanks for having me."
    )
    Entry.create!(
      name: "Tyrell",
      text:
        "This is perfection. A place worthy of my presence. Thank you " +
        "for hosting me in such an impeccable manner."
    )
    Entry.create!(
      name: "Elliot",
      text:
        "Nice... I guess. But let’s be real, this world is a glitch. " +
        "Nothing is as it seems. Thanks."
    )
    Message.destroy_all
    Message.create!(
      name: "Darlene",
      text:
        "Cool place, I guess. Might hack it later. Just kidding. Or am " +
        "I? ;) Thanks for having me."
    )
    Message.create!(
      name: "Tyrell",
      text:
        "This is perfection. A place worthy of my presence. Thank you " +
        "for hosting me in such an impeccable manner."
    )
    Message.create!(
      name: "Elliot",
      text:
        "Nice... I guess. But let’s be real, this world is a glitch. " +
        "Nothing is as it seems. Thanks."
    )
    redirect_to root_path
  end
end
