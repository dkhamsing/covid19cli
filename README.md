# covid19cli

Quick CLI for COVID-19 data :zap:

[![Ruby](https://github.com/dkhamsing/covid19cli/workflows/Ruby/badge.svg)
](https://github.com/dkhamsing/covid19cli/actions)

## Installation

```
$ git clone https://github.com/dkhamsing/covid19cli.git
$ cd covid19cli/
$ rake install
```

## Usage

```shell
Usage: covid19cli
       covid19cli [options]
    -d, --date [date]
    -s Confirmed, Deaths, Death Rate,
        --sort
    -t, --top [number]
    -c, --country [country]
        --states
        --counties
    -f, --filter [value]
        --history
        --key [key]
    -h, --help
```

```shell
> covid19cli

getting data for 03-27-2020
+----------------+-----------+-------+--------------+
| Country        | Confirmed | Death | Death Rate % |
+----------------+-----------+-------+--------------+
| US             |    101657 |  1581 |         1.56 |
| Italy          |     86498 |  9134 |        10.56 |
| China          |     81897 |  3296 |         4.02 |
| Spain          |     65719 |  5138 |         7.82 |
| Germany        |     50871 |   342 |         0.67 |
| France         |     33402 |  1997 |         5.98 |
| Iran           |     32332 |  2378 |         7.35 |
| United Kingdom |     14745 |   761 |         5.16 |
| Switzerland    |     12928 |   231 |         1.79 |
| South Korea    |      9332 |   139 |         1.49 |
| Netherlands    |      8647 |   547 |         6.33 |
| Austria        |      7657 |    58 |         0.76 |
| Belgium        |      7284 |   289 |         3.97 |
| Turkey         |      5698 |    92 |         1.61 |
| Canada         |      4682 |    54 |         1.15 |
| Portugal       |      4268 |    76 |         1.78 |
| Norway         |      3755 |    19 |         0.51 |
| Brazil         |      3417 |    92 |         2.69 |
| Australia      |      3143 |    13 |         0.41 |
| Sweden         |      3069 |   105 |         3.42 |
+----------------+-----------+-------+--------------+
Data from https://github.com/CSSEGISandData/COVID-19


> covid19cli -c Singapore

getting data for 03-27-2020
+-----------+-----------+-------+--------------+
| Country   | Confirmed | Death | Death Rate % |
+-----------+-----------+-------+--------------+
| Singapore |       732 |     2 |         0.27 |
+-----------+-----------+-------+--------------+
Data from https://github.com/CSSEGISandData/COVID-19


> covid19cli --states

getting data for 2020-03-27
+---------------+--------+-------+--------+--------------+
| State         | County | Cases | Deaths | Death Rate % |
+---------------+--------+-------+--------+--------------+
| New York      |        | 44635 |    535 |         1.20 |
| New Jersey    |        |  8825 |    108 |         1.22 |
| California    |        |  4914 |    102 |         2.08 |
| Washington    |        |  3770 |    177 |         4.69 |
| Michigan      |        |  3657 |     93 |         2.54 |
| Massachusetts |        |  3240 |     35 |         1.08 |
| Florida       |        |  3198 |     46 |         1.44 |
| Illinois      |        |  3029 |     37 |         1.22 |
| Louisiana     |        |  2746 |    119 |         4.33 |
| Pennsylvania  |        |  2218 |     23 |         1.04 |
+---------------+--------+-------+--------+--------------+
Data from https://github.com/nytimes/covid-19-data


> covid19cli --counties -f california

getting data for 2020-03-27
+------------+---------------+-------+--------+--------------+
| State      | County        | Cases | Deaths | Death Rate % |
+------------+---------------+-------+--------+--------------+
| California | Los Angeles   |  1465 |     27 |         1.84 |
| California | Santa Clara   |   574 |     21 |         3.66 |
| California | San Diego     |   417 |      5 |         1.20 |
| California | Orange        |   321 |      3 |         0.93 |
| California | San Francisco |   282 |      3 |         1.06 |
| California | Alameda       |   241 |      4 |         1.66 |
| California | San Mateo     |   239 |      6 |         2.51 |
| California | Riverside     |   185 |      8 |         4.32 |
| California | Sacramento    |   164 |      6 |         3.66 |
| California | Contra Costa  |   151 |      2 |         1.32 |
+------------+---------------+-------+--------+--------------+
Data from https://github.com/nytimes/covid-19-data


> covid19cli --states --history --key state -f California -t 30

+-------+------------+--------+-------+-----------+--------+------------+--------------+---------------+
| Date  | State      | County | Cases | New Cases | Deaths | New Deaths | Death Rate % | Death Plot    |
+-------+------------+--------+-------+-----------+--------+------------+--------------+---------------+
| 03-05 | California |        |    67 |        12 |      1 |          0 |         1.49 | .             |
| 03-06 | California |        |    81 |        14 |      1 |          0 |         1.23 | .             |
| 03-07 | California |        |   100 |        19 |      1 |          0 |         1.00 | .             |
| 03-08 | California |        |   112 |        12 |      1 |          0 |         0.89 | .             |
| 03-09 | California |        |   172 |        60 |      2 |          1 |         1.16 | .             |
| 03-10 | California |        |   179 |         7 |      3 |          1 |         1.68 | .             |
| 03-11 | California |        |   202 |        23 |      4 |          1 |         1.98 | .             |
| 03-12 | California |        |   252 |        50 |      4 |          0 |         1.59 | .             |
| 03-13 | California |        |   320 |        68 |      5 |          1 |         1.56 | .             |
| 03-14 | California |        |   381 |        61 |      5 |          0 |         1.31 | .             |
| 03-15 | California |        |   478 |        97 |      6 |          1 |         1.26 | .             |
| 03-16 | California |        |   588 |       110 |     11 |          5 |         1.87 | .             |
| 03-17 | California |        |   732 |       144 |     14 |          3 |         1.91 | .             |
| 03-18 | California |        |   893 |       161 |     17 |          3 |         1.90 | .             |
| 03-19 | California |        |  1067 |       174 |     19 |          2 |         1.78 | .             |
| 03-20 | California |        |  1283 |       216 |     24 |          5 |         1.87 | ..            |
| 03-21 | California |        |  1544 |       261 |     28 |          4 |         1.81 | ..            |
| 03-22 | California |        |  1851 |       307 |     35 |          7 |         1.89 | ..            |
| 03-23 | California |        |  2240 |       389 |     39 |          4 |         1.74 | ..            |
| 03-24 | California |        |  2644 |       404 |     52 |         13 |         1.97 | ...           |
| 03-25 | California |        |  3183 |       539 |     67 |         15 |         2.10 | ...           |
| 03-26 | California |        |  4060 |       877 |     82 |         15 |         2.02 | ....          |
| 03-27 | California |        |  4914 |       854 |    102 |         20 |         2.08 | .....         |
| 03-28 | California |        |  5565 |       651 |    121 |         19 |         2.17 | ......        |
| 03-29 | California |        |  6266 |       701 |    130 |          9 |         2.07 | ......        |
| 03-30 | California |        |  7421 |      1155 |    146 |         16 |         1.97 | .......       |
| 03-31 | California |        |  8582 |      1161 |    183 |         37 |         2.13 | ........      |
| 04-01 | California |        |  9816 |      1234 |    212 |         29 |         2.16 | ..........    |
| 04-02 | California |        | 10995 |      1179 |    243 |         31 |         2.21 | ...........   |
| 04-03 | California |        | 12569 |      1574 |    282 |         39 |         2.24 | ............. |
+-------+------------+--------+-------+-----------+--------+------------+--------------+---------------+
Data from https://github.com/nytimes/covid-19-data


> covid19cli --counties --history --key fips -f 06059 -t 10

+-------+------------+--------+-------+-----------+--------+------------+--------------+---------------+
| Date  | State      | County | Cases | New Cases | Deaths | New Deaths | Death Rate % | Death Plot    |
+-------+------------+--------+-------+-----------+--------+------------+--------------+---------------+
| 03-25 | California | Orange |   187 |        35 |      1 |          1 |         0.53 | .             |
| 03-26 | California | Orange |   256 |        69 |      1 |          0 |         0.39 | .             |
| 03-27 | California | Orange |   321 |        65 |      3 |          2 |         0.93 | ...           |
| 03-28 | California | Orange |   321 |         0 |      3 |          0 |         0.93 | ...           |
| 03-29 | California | Orange |   431 |       110 |      4 |          1 |         0.93 | ....          |
| 03-30 | California | Orange |   464 |        33 |      4 |          0 |         0.86 | ....          |
| 03-31 | California | Orange |   502 |        38 |      7 |          3 |         1.39 | .......       |
| 04-01 | California | Orange |   606 |       104 |     10 |          3 |         1.65 | ..........    |
| 04-02 | California | Orange |   606 |         0 |     10 |          0 |         1.65 | ..........    |
| 04-03 | California | Orange |   711 |       105 |     13 |          3 |         1.83 | ............. |
+-------+------------+--------+-------+-----------+--------+------------+--------------+---------------+
Data from https://github.com/nytimes/covid-19-data
```

## Credits
- [CSSE at Johns Hopkins University](https://github.com/CSSEGISandData/COVID-19)
- [The New York Times](https://github.com/nytimes/covid-19-data)
- [`terminal-table`](https://github.com/tj/terminal-table)


## Contact

- [github.com/dkhamsing](https://github.com/dkhamsing)
- [twitter.com/dkhamsing](https://twitter.com/dkhamsing)

## License

This project is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
