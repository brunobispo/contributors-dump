Contributors Dump
=================

Visualize and export contributors of github repositories.

### Dependencies
- Ruby 2.5
- Bundler gem

### Installation
Run `bundle` to install ruby gem dependencies.

### Running tests
Run `rspec` to run test suite

### Usage

    $ bin/contributors-dump [-f CVS|Table] <repository> <file>

To visualize the report as a table:

    $ bin/contributors-dump "brunobispo/dotfiles"
    +-------------+-------------------+------------+-----------------------------------------------------+----------+
    | Name        | Email             | Login      | Avatar                                              | Commits  |
    +-------------+-------------------+------------+-----------------------------------------------------+----------+
    | Bruno Bispo | me@brunobispo.com | brunobispo | https://avatars0.githubusercontent.com/u/858829?v=4 | 26       |
    +-------------+-------------------+------------+-----------------------------------------------------+----------+

To export the result to a file, provide a file path:

    $ bin/contributors-dump -f CSV "brunobispo/dotfiles" output.csv
