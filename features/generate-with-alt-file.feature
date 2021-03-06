Feature: reveal-ck generate --file

  By default, `reveal-ck generate` looks for a file named something
  like:

  * slides.md
  * slides.haml
  * slides.slim
  * slides.rb

  And this is known as your 'slides file.'

  However, if you'd prefer, you can create an alternate file like
  `slides_for_google_talk.md` and have reveal-ck use that instead.

  To do this, you'd say:

      reveal-ck generate --file slides_for_google_talk.haml

  When you do this, the output directory of the generated slides
  switches from `slides/` to the name of your slides file without the
  extension. This allows you to maintain several slide files in the
  same top-level directory which each one generating presentations
  into distinct subdirectories.

  Scenario: Generating basic slides any file
    Given a file named "slides_for_google_talk.haml" with:
    """
    %section
      %h2
        Uh oh!

    %section
      %h3
        Guess what day it is?

    %section
      %h3
        Guess what day it is!

    %section
      %h3
        Huh?

    %section
      %h3
        Anybody?
    """
    When I run `reveal-ck generate --file slides_for_google_talk.haml`
    Then the exit status should be 0
    And the output should contain exactly "Generating slides for 'slides_for_google_talk.haml'..\n"
    And the following files should exist:
    | slides_for_google_talk/slides.html |
    | slides_for_google_talk/index.html  |
