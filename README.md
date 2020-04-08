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

data for 04-07-2020
+----------------+-----------+--------+--------+
| Country        | Confirmed | Deaths | Death  |
|                |           |        | Rate   |
+----------------+-----------+--------+--------+
| US             |    396223 |  12722 |  3.21% |
| Spain          |    141942 |  14045 |  9.89% |
| Italy          |    135586 |  17127 | 12.63% |
| France         |    110065 |  10343 |  9.40% |
| Germany        |    107663 |   2016 |  1.87% |
| China          |     82718 |   3335 |  4.03% |
| Iran           |     62589 |   3872 |  6.19% |
| United Kingdom |     55949 |   6171 | 11.03% |
| Turkey         |     34109 |    725 |  2.13% |
| Switzerland    |     22253 |    821 |  3.69% |
| Belgium        |     22194 |   2035 |  9.17% |
| Netherlands    |     19709 |   2108 | 10.70% |
| Canada         |     17872 |    375 |  2.10% |
| Brazil         |     14034 |    686 |  4.89% |
| Austria        |     12639 |    243 |  1.92% |
| Portugal       |     12442 |    345 |  2.77% |
| South Korea    |     10331 |    192 |  1.86% |
| Israel         |      9248 |     65 |  0.70% |
| Sweden         |      7693 |    591 |  7.68% |
| Russia         |      7497 |     58 |  0.77% |
+----------------+-----------+--------+--------+
Data from https://github.com/CSSEGISandData/COVID-19


> covid19cli -c Singapore

data for 04-07-2020
+-----------+-----------+--------+-------+
| Country   | Confirmed | Deaths | Death |
|           |           |        | Rate  |
+-----------+-----------+--------+-------+
| Singapore |      1481 |      6 | 0.41% |
+-----------+-----------+--------+-------+
Data from https://github.com/CSSEGISandData/COVID-19


> covid19cli --states

data for 2020-04-06
+---------------+--------+--------+--------+-------+
| State         | County | Cases  | Deaths | Death |
|               |        |        |        | Rate  |
+---------------+--------+--------+--------+-------+
| New York      |        | 130703 |   4758 | 3.64% |
| New Jersey    |        |  41090 |   1005 | 2.45% |
| Michigan      |        |  17130 |    727 | 4.24% |
| California    |        |  16284 |    386 | 2.37% |
| Louisiana     |        |  14867 |    512 | 3.44% |
| Massachusetts |        |  13837 |    260 | 1.88% |
| Florida       |        |  13621 |    253 | 1.86% |
| Pennsylvania  |        |  13074 |    169 | 1.29% |
| Illinois      |        |  12262 |    309 | 2.52% |
| Washington    |        |   8384 |    383 | 4.57% |
+---------------+--------+--------+--------+-------+
Data from https://github.com/nytimes/covid-19-data


> covid19cli --counties -f california

data for 2020-04-06
+------------+----------------+-------+--------+-------+
| State      | County         | Cases | Deaths | Death |
|            |                |       |        | Rate  |
+------------+----------------+-------+--------+-------+
| California | Los Angeles    |  6360 |    147 | 2.31% |
| California | San Diego      |  1404 |     19 | 1.35% |
| California | Santa Clara    |  1224 |     40 | 3.27% |
| California | Riverside      |   946 |     25 | 2.64% |
| California | Orange         |   882 |     14 | 1.59% |
| California | Alameda        |   609 |     13 | 2.13% |
| California | San Francisco  |   586 |      9 | 1.54% |
| California | San Mateo      |   579 |     13 | 2.25% |
| California | San Bernardino |   530 |     16 | 3.02% |
| California | Sacramento     |   461 |     18 | 3.90% |
+------------+----------------+-------+--------+-------+
Data from https://github.com/nytimes/covid-19-data


> covid19cli --states --history --key state -f California -t 30

last 30 days states historical data for state = California
+-------+------------+--------+-------+-------+-----------+--------+--------+-----------+-------+
| Date  | State      | County | Cases | New   | New       | Deaths | New    | New       | Death |
|       |            |        |       | Cases | Cases     |        | Deaths | Deaths    | Rate  |
+-------+------------+--------+-------+-------+-----------+--------+--------+-----------+-------+
| 03-08 | California |        |   112 |    12 | .         |      1 |      0 | .         | 0.89% |
| 03-09 | California |        |   172 |    60 | .         |      2 |      1 | .         | 1.16% |
| 03-10 | California |        |   179 |     7 | .         |      3 |      1 | .         | 1.68% |
| 03-11 | California |        |   202 |    23 | .         |      4 |      1 | .         | 1.98% |
| 03-12 | California |        |   252 |    50 | .         |      4 |      0 | .         | 1.59% |
| 03-13 | California |        |   320 |    68 | .         |      5 |      1 | .         | 1.56% |
| 03-14 | California |        |   381 |    61 | .         |      5 |      0 | .         | 1.31% |
| 03-15 | California |        |   478 |    97 | .         |      6 |      1 | .         | 1.26% |
| 03-16 | California |        |   588 |   110 | .         |     11 |      5 | .         | 1.87% |
| 03-17 | California |        |   732 |   144 | .         |     14 |      3 | .         | 1.91% |
| 03-18 | California |        |   893 |   161 | .         |     17 |      3 | .         | 1.90% |
| 03-19 | California |        |  1067 |   174 | ..        |     19 |      2 | .         | 1.78% |
| 03-20 | California |        |  1283 |   216 | ..        |     24 |      5 | .         | 1.87% |
| 03-21 | California |        |  1544 |   261 | ..        |     28 |      4 | .         | 1.81% |
| 03-22 | California |        |  1851 |   307 | ..        |     35 |      7 | ..        | 1.89% |
| 03-23 | California |        |  2240 |   389 | ...       |     39 |      4 | .         | 1.74% |
| 03-24 | California |        |  2644 |   404 | ...       |     52 |     13 | ...       | 1.97% |
| 03-25 | California |        |  3183 |   539 | ....      |     67 |     15 | ...       | 2.10% |
| 03-26 | California |        |  4060 |   877 | ......    |     82 |     15 | ...       | 2.02% |
| 03-27 | California |        |  4914 |   854 | .....     |    102 |     20 | ....      | 2.08% |
| 03-28 | California |        |  5565 |   651 | ....      |    121 |     19 | ....      | 2.17% |
| 03-29 | California |        |  6266 |   701 | .....     |    130 |      9 | ..        | 2.07% |
| 03-30 | California |        |  7421 |  1155 | .......   |    146 |     16 | ....      | 1.97% |
| 03-31 | California |        |  8582 |  1161 | .......   |    183 |     37 | ........  | 2.13% |
| 04-01 | California |        |  9816 |  1234 | ........  |    212 |     29 | ......    | 2.16% |
| 04-02 | California |        | 11190 |  1374 | ........  |    247 |     35 | .......   | 2.21% |
| 04-03 | California |        | 12569 |  1379 | ......... |    282 |     35 | .......   | 2.24% |
| 04-04 | California |        | 13796 |  1227 | ........  |    323 |     41 | ......... | 2.34% |
| 04-05 | California |        | 15076 |  1280 | ........  |    349 |     26 | ......    | 2.31% |
| 04-06 | California |        | 16284 |  1208 | ........  |    386 |     37 | ........  | 2.37% |
+-------+------------+--------+-------+-------+-----------+--------+--------+-----------+-------+
Data from https://github.com/nytimes/covid-19-data


> covid19cli --counties --history --key fips -f 06059 -t 10

last 10 days counties historical data for fips = 06059
+-------+------------+--------+-------+-------+-----------+--------+--------+-----------+-------+
| Date  | State      | County | Cases | New   | New       | Deaths | New    | New       | Death |
|       |            |        |       | Cases | Cases     |        | Deaths | Deaths    | Rate  |
+-------+------------+--------+-------+-------+-----------+--------+--------+-----------+-------+
| 03-28 | California | Orange |   321 |     0 | .         |      3 |      0 | .         | 0.93% |
| 03-29 | California | Orange |   431 |   110 | ......... |      4 |      1 | ...       | 0.93% |
| 03-30 | California | Orange |   464 |    33 | ...       |      4 |      0 | .         | 0.86% |
| 03-31 | California | Orange |   502 |    38 | ...       |      7 |      3 | ......... | 1.39% |
| 04-01 | California | Orange |   606 |   104 | ........  |     10 |      3 | ......... | 1.65% |
| 04-02 | California | Orange |   656 |    50 | ....      |     13 |      3 | ......... | 1.98% |
| 04-03 | California | Orange |   711 |    55 | .....     |     13 |      0 | .         | 1.83% |
| 04-04 | California | Orange |   786 |    75 | ......    |     14 |      1 | ...       | 1.78% |
| 04-05 | California | Orange |   834 |    48 | ....      |     14 |      0 | .         | 1.68% |
| 04-06 | California | Orange |   882 |    48 | ....      |     14 |      0 | .         | 1.59% |
+-------+------------+--------+-------+-------+-----------+--------+--------+-----------+-------+
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
