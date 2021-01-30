@testable import muterCore

import SwiftSyntax

import Foundation
import TestingExtensions
import Quick
import Nimble

class HTMLReportSpec: QuickSpec {
    override func spec() {
        let now = {
            DateComponents(
                calendar: .init(identifier: .gregorian),
                year: 2021,
                month: 1,
                day: 20,
                hour: 2,
                minute: 42
            ).date!
        }()

        let sut = HTMLReporter(now: { now })
        let outcomes = (0...50).map {
            MutationTestOutcome.make(
                testSuiteOutcome: nextMutationTestOutcome($0),
                mutationPoint: .make(
                    mutationOperatorId: nextMutationOperator($0),
                    filePath: "/root/file\($0).swift",
                    position: .init(integerLiteral: $0)
                ),
                mutationSnapshot: .make(before: "before", after: "after"),
                originalProjectDirectoryUrl: URL(fileURLWithPath: "/root/")
            )
        }

        describe("HTMLReport") {
            it("should output an HTML file") {
                let html = sut.report(from: outcomes)

                expect(html).to(equalWithDiff(expectedHTMLReport))
            }
        }
    }
}

let expectedHTMLReport =
"""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>Muter Report</title>
    <style>
        /*! normalize.css v8.0.1 | MIT License | github.com/necolas/normalize.css */

/* Document
========================================================================== */

/**
* 1. Correct the line height in all browsers.
* 2. Prevent adjustments of font size after orientation changes in iOS.
*/

html {
    line-height: 1.15;
    /* 1 */
    -webkit-text-size-adjust: 100%;
    /* 2 */
}

/* Sections
========================================================================== */

/**
* Remove the margin in all browsers.
*/

body {
    margin: 0;
}

/**
* Render the `main` element consistently in IE.
*/

main {
    display: block;
}

/**
* Correct the font size and margin on `h1` elements within `section` and
* `article` contexts in Chrome, Firefox, and Safari.
*/

h1 {
    font-size: 2em;
    margin: 0.67em 0;
}

/* Grouping content
========================================================================== */

/**
* 1. Add the correct box sizing in Firefox.
* 2. Show the overflow in Edge and IE.
*/

hr {
    box-sizing: content-box;
    /* 1 */
    height: 0;
    /* 1 */
    overflow: visible;
    /* 2 */
}

/**
* 1. Correct the inheritance and scaling of font size in all browsers.
* 2. Correct the odd `em` font sizing in all browsers.
*/

pre {
    font-family: monospace, monospace;
    /* 1 */
    font-size: 1em;
    /* 2 */
}

/* Text-level semantics
========================================================================== */

/**
* Remove the gray background on active links in IE 10.
*/

a {
    background-color: transparent;
}

/**
* 1. Remove the bottom border in Chrome 57-
* 2. Add the correct text decoration in Chrome, Edge, IE, Opera, and Safari.
*/

abbr[title] {
    border-bottom: none;
    /* 1 */
    text-decoration: underline;
    /* 2 */
    text-decoration: underline dotted;
    /* 2 */
}

/**
* Add the correct font weight in Chrome, Edge, and Safari.
*/

b,
strong {
    font-weight: bolder;
}

/**
* 1. Correct the inheritance and scaling of font size in all browsers.
* 2. Correct the odd `em` font sizing in all browsers.
*/

code,
kbd,
samp {
    font-family: monospace, monospace;
    /* 1 */
    font-size: 1em;
    /* 2 */
}

/**
* Add the correct font size in all browsers.
*/

small {
    font-size: 80%;
}

/**
* Prevent `sub` and `sup` elements from affecting the line height in
* all browsers.
*/

sub,
sup {
    font-size: 75%;
    line-height: 0;
    position: relative;
    vertical-align: baseline;
}

sub {
    bottom: -0.25em;
}

sup {
    top: -0.5em;
}

/* Embedded content
========================================================================== */

/**
* Remove the border on images inside links in IE 10.
*/

img {
    border-style: none;
}

/* Forms
========================================================================== */

/**
* 1. Change the font styles in all browsers.
* 2. Remove the margin in Firefox and Safari.
*/

button,
input,
optgroup,
select,
textarea {
    font-family: inherit;
    /* 1 */
    font-size: 100%;
    /* 1 */
    line-height: 1.15;
    /* 1 */
    margin: 0;
    /* 2 */
}

/**
* Show the overflow in IE.
* 1. Show the overflow in Edge.
*/

button,
input {
    /* 1 */
    overflow: visible;
}

/**
* Remove the inheritance of text transform in Edge, Firefox, and IE.
* 1. Remove the inheritance of text transform in Firefox.
*/

button,
select {
    /* 1 */
    text-transform: none;
}

/**
* Correct the inability to style clickable types in iOS and Safari.
*/

button,
[type="button"],
[type="reset"],
[type="submit"] {
    -webkit-appearance: button;
}

/**
* Remove the inner border and padding in Firefox.
*/

button::-moz-focus-inner,
[type="button"]::-moz-focus-inner,
[type="reset"]::-moz-focus-inner,
[type="submit"]::-moz-focus-inner {
    border-style: none;
    padding: 0;
}

/**
* Restore the focus styles unset by the previous rule.
*/

button:-moz-focusring,
[type="button"]:-moz-focusring,
[type="reset"]:-moz-focusring,
[type="submit"]:-moz-focusring {
    outline: 1px dotted ButtonText;
}

/**
* Correct the padding in Firefox.
*/

fieldset {
    padding: 0.35em 0.75em 0.625em;
}

/**
* 1. Correct the text wrapping in Edge and IE.
* 2. Correct the color inheritance from `fieldset` elements in IE.
* 3. Remove the padding so developers are not caught out when they zero out
*    `fieldset` elements in all browsers.
*/

legend {
    box-sizing: border-box;
    /* 1 */
    color: inherit;
    /* 2 */
    display: table;
    /* 1 */
    max-width: 100%;
    /* 1 */
    padding: 0;
    /* 3 */
    white-space: normal;
    /* 1 */
}

/**
* Add the correct vertical alignment in Chrome, Firefox, and Opera.
*/

progress {
    vertical-align: baseline;
}

/**
* Remove the default vertical scrollbar in IE 10+.
*/

textarea {
    overflow: auto;
}

/**
* 1. Add the correct box sizing in IE 10.
* 2. Remove the padding in IE 10.
*/

[type="checkbox"],
[type="radio"] {
    box-sizing: border-box;
    /* 1 */
    padding: 0;
    /* 2 */
}

/**
* Correct the cursor style of increment and decrement buttons in Chrome.
*/

[type="number"]::-webkit-inner-spin-button,
[type="number"]::-webkit-outer-spin-button {
    height: auto;
}

/**
* 1. Correct the odd appearance in Chrome and Safari.
* 2. Correct the outline style in Safari.
*/

[type="search"] {
    -webkit-appearance: textfield;
    /* 1 */
    outline-offset: -2px;
    /* 2 */
}

/**
* Remove the inner padding in Chrome and Safari on macOS.
*/

[type="search"]::-webkit-search-decoration {
    -webkit-appearance: none;
}

/**
* 1. Correct the inability to style clickable types in iOS and Safari.
* 2. Change font properties to `inherit` in Safari.
*/

::-webkit-file-upload-button {
    -webkit-appearance: button;
    /* 1 */
    font: inherit;
    /* 2 */
}

/* Interactive
========================================================================== */

/*
* Add the correct display in Edge, IE 10+, and Firefox.
*/

details {
    display: block;
}

/*
* Add the correct display in all browsers.
*/

summary {
    display: list-item;
}

/* Misc
========================================================================== */

/**
* Add the correct display in IE 10+.
*/

template {
    display: none;
}

/**
* Add the correct display in IE 10.
*/

[hidden] {
    display: none;
}    body {
    background-color: #FAFAFA;
    font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji
}body {
    background-color: #FAFAFA;
    color: #000000;
    font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji
}

h1 {
    font-size: 3em;
    margin: 0;
}

.report {
    font-size: 15px;
    font-weight: normal;
    margin: auto;
    padding: 30px;
    min-width: 210mm;
    max-width: 610mm;
}

header {
    position: relative;
    width: 100%;
    display: flex;
    align-items: flex-end;
    align-content: stretch;
    text-align: right;
}

.header-item {
    padding: 10px;
    flex: auto;
}

.box {
    border-radius: 8px;
    padding: 15px;
    color: #ffffff;
}

header:after {
    content: "";
    display: flex;
    clear: both;
}

.small {
    font-variant: small-caps;
    font-weight: normal;
}

.strong {
    font-size: 20px;
    font-weight: bolder;
}

.divider {
    display: flex;
    flex-direction: row;
    padding-top: 30px;
}

.divider-content {
    font-variant: small-caps;
    font-size: 20px;
    padding: 0px 30px;
}

.divider:before,
.divider:after {
    content: "";
    flex: 1 1;
    border-bottom: 1px solid #000000;
    margin: auto;
}

table {
    table-layout: fixed;
    border-collapse: collapse;
    width: 100%;
    empty-cells: hide;
    word-wrap: break-word;
}

td,
th {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
}

tr:nth-child(even) {
    background-color: #dfe4ea;
}

tr:nth-child(odd) {
    background-color: #f1f2f6;
}

tr:hover {
    background-color: #ecf5e1;
}

th {
    color: #fff;
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: center;
    background-color: #3498db;
}

.left-aligned {
    text-align: left;
}

.right-aligned {
    text-align: right;
}

.failed {
    height: 30px;
}

.passed {
    height: 30px;
}

.build-error {
    height: 30px;
}

.footer {
    left: 0;
    bottom: 0;
    width: 100%;
    text-align: center;
}

.toggle {
    float: right;
    padding: 5px 0px 10px 0px;
}

.logo {
    padding-bottom: 10px;
    width: 400px;
}

.snapshot-before {
    padding: 8px;
    align-content: stretch;
    background-color: #ffeef0;
    flex: 1;
}

.snapshot-arrow {
    align-self: center;
}

.snapshot-after {
    padding: 8px;
    background-color: #e6ffed;
    flex: 1;
}

.snapshot-changes {
    display: flex;
    justify-content: space-around;
    align-self: center;
    align-content: stretch;
}

.snapshot-changes  {
    align-self: center;
    align-content: stretch;
    width: 100%;
}

@media (prefers-color-scheme: dark) {
    body {
        color: #eee;
        background: #0d1117;
    }
    
    p, span, label, h1 {
        color: #ffffff;
    }
    
    .snapshot-before {
        background-color: rgba(218,54,51,0.2);
    }
    
    .snapshot-after {
        background-color: rgba(46,160,67, 0.2);
    }
    
    .divider:before,
    .divider:after {
        border-bottom: 1px solid #ffffff;
    }
    
    tr:nth-child(even) {
        background-color: #1b2430;
    }
    
    tr:nth-child(odd) {
        background-color: #0d1117;
    }
    
    tr:hover {
        background-color: #293649;
    }
    
    th {
        background-color: #293649;
    }
}
    </style>
    <script>
        window.onload = function() {
    showHide(false, 'mutation-operators-per-file');
    showHide(false, 'applied-operators');
};

function isSnapshotRow(row) {
    return row && new RegExp("snapshot").test(row.className);
}

function showHide(shouldShow, tableId) {
    var rows = Array.from(document.getElementById(tableId).tBodies[0].rows)
    .filter(row => { return !isSnapshotRow(row); });
    
    var displayCount = shouldShow ? rows.length : 9;
    
    showFirstRows(rows, displayCount);
}

function showFirstRows(rows, count) {
    rows.slice(0, count).forEach(row => { row.style.display = "table-row"; });
    
    const remeaning = Math.max(rows.length - count - 1, 0);
    
    if (remeaning != 0) {
        rows.slice(-remeaning).forEach(row => { row.style.display = "none"; });
    }
}

function showChange(button) {
    const changes = button.parentElement.parentElement.nextElementSibling.firstElementChild;
    const isHidding = changes.style.display == "table-cell";
    
    
    if (isHidding) {
        changes.style.display = "none";
        button.innerHTML = "+";
    } else {
        changes.style.display = "table-cell";
        button.innerHTML = "-";
    }
}
    </script>
</head>
    <body>
        <div class="report">
            <header>
                <div class="logo">
                    <svg viewBox="0 0 1121 354" width="100%">
    <style>
        .a {
            fill: #1e2434
        }

        @media (prefers-color-scheme: dark) {
            .a {
                fill: #9ea9c7
            }
        }
        
        .b,
        .c {
            fill-opacity: .4;
            fill: #fff
        }
        
        .c {
            fill-opacity: .7
        }
    </style>
    <g fill="none">
        <g fill="#E22807">
            <path
            d="M47.059 170.2c6.4.2 11.2 1.8 14.2 4.9 3 3.1 17.3 17.6 43 43.4 25.2-25.6 39.5-40 42.7-43.2 3.1-3.3 7.8-5 14.1-5 12.6 0 18.9 6.4 18.9 19.1v115.1c0 12.8-6.4 19.3-19.2 19.4-12.5 0-18.9-6.5-19.1-19.4v-67.7l-23.6 24.4c-3.1 3.2-7.8 4.7-14.2 4.7-5 .4-10-1.3-13.8-4.7-3.3-3.4-11.2-11.4-23.9-24.2v67.4c0 12.7-6.3 19.1-18.8 19.1-12.6 0-18.9-6.4-18.9-19.1V189.3c0-12.8 6.3-19.1 18.9-19.1h-.3zM216.459 170c12.6 0 19 6.2 19.1 18.5v58.4c.2 25.6 9.8 38.5 28.8 38.5 19.1.1 28.5-12.8 28.3-38.6v-57.7c.2-12.7 6.5-19.1 19.1-19.3 12.6.4 18.9 6.8 18.9 19.5v57.6c0 51.1-22.1 76.6-66.4 76.6-44.4.4-66.7-25.2-66.8-76.6v-57.8c.1-12.6 6.4-18.9 18.8-19l.2-.1zM364.559 170l96 .2c11.8.2 17.7 6.4 17.8 18.6 0 13-6.4 19.6-19.2 19.9h-28.3l.1 95.8c-.1 12.6-6.5 18.9-19 19.1-12.6.1-18.9-6.1-19-18.6l.1-96.3h-28.5c-12.7 0-19-6.4-19-19.3s6.4-19.4 19-19.4zM512.759 170l96 .2c11.7.2 17.7 6.4 17.8 18.6 0 13-6.5 19.6-19.3 19.9h-75.4V285h75.4c12.8 0 19.1 6.5 19.1 19.4 0 12.6-6.2 19-18.7 19.1h-94.9c-12.6 0-18.9-6.2-19-18.6V189.4c.1-12.7 6.4-19.2 19-19.4zm28.3 77.3c0-12.7 6.3-19.2 18.7-19.4h38.1c12.5 0 18.9 6.3 19.2 19.1-.3 12.8-6.7 19.1-19.2 19h-38.1c-12.6 0-18.8-6.3-18.8-18.9l.1.2zM728.959 170.2c12.4.1 24.3 5.3 32.8 14.5 9.1 8.6 14.2 20.6 14.1 33.2.4 11.6-2 23.2-7 33.6-4.7 9.1-11.9 13.8-21.5 14.2l23.3 23.9c3.9 4 5.9 9.3 5.7 14.9-.2 12.7-6.5 19.1-18.9 19.1h-.4c-6.3 0-12.5-3.2-18.6-9.4l-38-47.7c-6.4-6.9-9.6-13.5-9.7-19.8 0-12.9 6.4-19.4 19.2-19.3h13.4c10 .2 15-2.9 14.8-9.2-.2-6.3-5.1-9.5-14.9-9.5h-41.9v95.7c.1 12.8-6.2 19.1-19.1 19-12.8 0-19.1-6.4-18.8-18.9V189.1c0-12.5 6.3-18.8 18.8-18.9h66.7z" />
        </g>
        <path d="M.159 337.7v15.5l1120 .3V338z" class="a" />
        <path
        d="M1098.859 338l-.7-2.5c-3.2-11.4-13.1-19.3-24.7-19.9l-11.1-.5c-2.9-.1-5.7-1.4-7.7-3.5l-5.1-5.2c-4.2-4.1-9.5-6.8-15.3-7.7l-3.4-30.5c-.6-6.6-6.1-11.6-12.7-11.6h-15.8c-3.6-.1-7 1.4-9.5 4l-1.5 1.6-63.8-14.8-12.5 41.2-25.4-12.9h-34.6l-17.7 34.9c-.6.1-1.2.4-1.9.6l-14.1 5.3c-5.7 2.1-10.1 6.8-12 12.6l-2.8 8.7 292.3.2z"
        class="a" />
        <path d="M1015.859 272l3 27.6-16.2 2.2c-4.1.5-8 2-11.4 4.3V284l11.8-12.1 12.8.1z" class="b" />
        <path
        d="M916.359 337.8h-44.6l-3.2-9.8c-1.5-4.8-4.7-8.8-9-11.3l-6.2-3.6 11.1-21.9h21.6l16.7 8.5 13.6 38.1zM1082.859 338h-95.3l8.5-14.9c1.8-3.2 5-5.4 8.6-5.8l24-3.4c3.6-.5 7.3.8 9.9 3.4l5.1 5.2c4.8 4.8 11.2 7.7 17.9 8l11 .5c4.5.2 8.4 2.9 10.3 7z"
        class="c" />
        <path fill="#fff" fill-opacity=".9"
        d="M855.659 337.8h-33l1.2-3.9c.5-1.3 1.5-2.4 2.8-2.9l14.1-5.3c1.3-.5 2.7-.3 3.9.3l7.3 4.2c1 .6 1.7 1.5 2.1 2.6l1.6 5z" />
        <path fill="#649E02"
        d="M968.259 338l23-31.9.3-43.9.2-207-62.2-54.7h-75.6V8c0 11.8 4.4 23.2 12.4 31.8l-29.5 38 9 7.8c15.1 13.4 37.4 14 53.2 1.5l8.7 6.9-20.4 13.3 10.6 12.3c8.9 10.4 23.3 13.9 35.9 8.8l-9.6 25.5-57.5-39.2c-12.6-9.1-30-6-39 6.7-8.9 12.8-5.9 30.5 6.7 39.6l48.6 36.2 17.5 27.5 27.3 22.7-12.6 41.2 17.6 49.2 35.4.2z" />
        <path fill="#fff" fill-opacity=".8"
        d="M975.959 327.3l-7.7 10.7-35.4-.2-8.9-25 21.5-70.7-33.3-27.8-17.8-27.8-50.8-37.9c-4-3-5.9-8.2-4.8-13.1 1.1-5 4.9-8.8 9.8-9.8 3.4-.7 6.8 0 9.6 1.9l73.4 50.3 18-48V72l-31.1-32.9h-18.6c-14 0-26.2-9.6-29.7-23.3h53.7l52.6 46.3-.5 265.2z" />
        <path fill="#fff" fill-opacity=".6"
        d="M934.259 78.2v17.2l-36.6-29-4.7 5.3c-9 10.1-24 11.7-34.9 3.9l20.4-26.3c6.6 3.6 14 5.5 21.4 5.5h12.1l22.3 23.4z" />
        <path d="M920.359 104.1l10.5 8.3c-6.4 4.3-14.9 3.5-20.4-1.8l9.9-6.5z" class="b" />
    </g>
</svg>
                </div>
                <div class="header-item">
                    <div class="box" style="background-color: #92b300;">
                        <p class="small">Mutation Score</p>
                        <h1>68%</h1>
                    </div>
                </div>
                <div class="header-item">
                    <div class="box" style="background-color: #3498db;">
                        <p class="small">Operators Applied</p>
                        <h1>51</h1>
                    </div>
                </div>
            </header>
            <main>
                <div class="summary">
                    <p>In total, Muter introduced
                        <span class="strong">51</span> mutants in
                        <span class="strong">51</span> files.
                    </p>
                </div>
                <div class="divider">
                    <span class="divider-content">Mutation Operators per File</span>
                </div>
                <div class="mutation-operators-per-file">
                    <div class="toggle">
                        <input id="show-more-mutation-operators-per-file" type="checkbox" onclick="showHide(this.checked, 'mutation-operators-per-file');" />
                        <label for="show-more-mutation-operators-per-file">Show all</label>
                    </div>
                    <table id="mutation-operators-per-file">
    <thead>
    <tr>
        <th>File</th>
        <th># of Introduced Mutants</th>
        <th>Mutation Score</th>
    </tr>
</thead>
    <tbody>
    <tr>
  <td class="left-aligned">file0.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file1.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file2.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file3.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file4.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file5.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file6.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file7.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file8.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file9.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file10.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file11.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file12.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file13.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file14.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file15.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file16.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file17.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file18.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file19.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file20.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file21.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file22.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file23.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file24.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file25.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file26.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file27.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file28.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file29.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file30.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file31.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file32.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file33.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file34.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file35.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file36.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file37.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file38.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file39.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file40.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file41.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file42.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file43.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file44.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file45.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file46.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file47.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file48.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
<tr>
  <td class="left-aligned">file49.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #51a100;">100</td>
</tr>
<tr>
  <td class="left-aligned">file50.swift</td>
  <td class="right-aligned">1</td>
  <td class="right-aligned" style="color: #f70000;">0</td>
</tr>
    </tbody>
</table>
                </div>
                <div class="divider">
                    <span class="divider-content">Applied Mutation Operators</span>
                </div>
                <div class="applied-operators">
                    <div class="toggle">
                        <input id="show-more-applied-operators" type="checkbox" onclick="showHide(this.checked, 'applied-operators');" />
                        <label for="show-more-applied-operators">Show all</label>
                    </div>
                    <table id="applied-operators">
    <thead>
    <tr>
        <th>File</th>
        <th>Applied Mutation Operator</th>
        <th>Changes</th>
        <th>Mutation Test Result</th>
    </tr>
</thead>
    <tbody>
    <tr>
    <td class="left-aligned">file0.swift:0</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file1.swift:1</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file2.swift:2</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file3.swift:3</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file4.swift:4</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file5.swift:5</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file6.swift:6</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file7.swift:7</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file8.swift:8</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file9.swift:9</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file10.swift:10</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file11.swift:11</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file12.swift:12</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file13.swift:13</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file14.swift:14</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file15.swift:15</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file16.swift:16</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file17.swift:17</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file18.swift:18</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file19.swift:19</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file20.swift:20</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file21.swift:21</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file22.swift:22</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file23.swift:23</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file24.swift:24</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file25.swift:25</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file26.swift:26</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file27.swift:27</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file28.swift:28</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file29.swift:29</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file30.swift:30</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file31.swift:31</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file32.swift:32</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file33.swift:33</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file34.swift:34</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file35.swift:35</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file36.swift:36</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file37.swift:37</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file38.swift:38</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file39.swift:39</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file40.swift:40</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file41.swift:41</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file42.swift:42</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file43.swift:43</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file44.swift:44</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file45.swift:45</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file46.swift:46</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file47.swift:47</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (runtime error)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file48.swift:48</td>
    <td class="left-aligned"><wbr>Relational Operator Replacement<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="failed" role="img" viewBox="0 0 72 72">
    <title>mutant survived</title>
    <path fill="#ea5a47" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.217 36l-14.36 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M58.14 21.78l-7.76-8.013-14.29 14.22-14.22-14.22-8.013 8.013L28.207 36l-14.35 14.22 8.014 8.013 14.22-14.22 14.29 14.22 7.76-8.013L43.921 36z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file49.swift:49</td>
    <td class="left-aligned"><wbr>Remove Side Effects<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
</div></td>
    <td><svg class="passed" role="img" viewBox="0 0 72 72">
    <title>mutant killed (test failure)</title>
    <path fill="#b1cc33" d="m61.5 23.3-8.013-8.013-25.71 25.71-9.26-9.26-8.013 8.013 17.42 17.44z"/>
    <path fill="none" stroke="#000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M10.5 39.76L27.92 57.2 61.5 23.31l-8.013-8.013-25.71 25.71-9.26-9.26z"/>
</svg></td>
</tr>
<tr>
    <td class="left-aligned">file50.swift:50</td>
    <td class="left-aligned"><wbr>Change Logical Connector<wbr></td>
    <td class="mutation-snapshot"><div class="snapshot-changes">
    <span class="snapshot-before">before</span>
<span class="snapshot-arrow">→</span>
<span class="snapshot-after">after</span>
</div></td>
    <td><svg class="build-error" role="img" viewBox="0 0 72 72">
    <title>build error</title>
    <path fill="#FFF" d="M40.526 16.92a14.934 14.934 0 00-4.336-.645h-.03a15.731 15.731 0 00-3.121.324 15.412 15.412 0 00-9.095 5.832 17.022 17.022 0 00-3.267 7.59 17.404 17.404 0 004.02 14.42l.112.126c.884.996 2.094 2.362 2.094 3.814l-.019 4.178a.838.838 0 01-.837.837 25.063 25.063 0 005.873 2.124c3.192.72 6.514.629 9.662-.263 2.693-12.712 1.982-25.99-1.056-38.337z"/>
    <path fill="#D0CFCE" d="M46.98 20.812a15.5 15.5 0 00-6.454-3.893c3.038 12.348 3.75 25.626 1.054 38.332a22.514 22.514 0 004.69-1.902.846.846 0 01-.85-.825l-.057-4.14c0-1.383 1.173-2.673 2.028-3.616.121-.134.237-.26.34-.38 5.907-6.861 5.583-17.1-.746-23.575h-.005z"/>
    <path fill="#3F3F3F" d="M29.37 35.24a4 4 0 100 8 4 4 0 000-8zM43.062 35.24a4 4 0 100 8 4 4 0 000-8z"/>
    <path fill="#FFF" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
    <g fill="none" stroke="#000" stroke-width="2">
    <path stroke-linecap="round" stroke-linejoin="round" d="M46.255 52.473l-.058-4.14c0-1.215 1.381-2.543 2.161-3.435A18.046 18.046 0 0052.79 32.97c0-9.716-7.45-17.594-16.63-17.575a16.518 16.518 0 00-3.288.341c-6.608 1.355-11.874 7.083-13.022 14.106a18.22 18.22 0 004.224 15.11c.768.87 1.995 2.195 1.995 3.385l-.018 4.173M29.371 51.081v4.004M34.157 51.973v4.005M43.063 51.081v4.004M38.72 51.973v4.005"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M33.702 48.742l2.456-4.899 2.936 4.899"/>
    <circle cx="29.371" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <circle cx="43.063" cy="39.2" r="4.188" stroke-miterlimit="10"/>
    <path stroke-linecap="round" stroke-linejoin="round" d="M53.015 20.665a460.015 460.015 0 012.416-2.39s1.943 1.84 3.27 1.443c1.373-.41 2.156-1.808 2.035-2.954-.167-1.588-2.11-3.04-4.438-2.556.406-1.513.068-3.062-.933-3.995-1.654-1.54-4.078-.479-4.99.918-1.22 1.869 1.574 3.663 1.574 3.663a410.45 410.45 0 00-2.177 2.151M19.678 46.908c-1.549 1.54-2.6 2.58-2.92 2.89-.655-1.302-2.132-1.943-3.458-1.546-1.374.411-2.157 1.808-2.036 2.954.168 1.589 2.11 3.04 4.438 2.556-.405 1.513-.068 3.062.933 3.995 1.654 1.54 4.33.614 4.99-.918.47-1.088.193-2.297-1.438-3.505.26-.252 1.005-.99 2.11-2.087M19.113 20.792a489.893 489.893 0 00-2.543-2.516s-1.944 1.839-3.27 1.442c-1.374-.411-2.157-1.808-2.036-2.954.168-1.589 2.11-3.04 4.438-2.556-.405-1.513-.068-3.062.933-3.995 1.654-1.54 4.078-.479 4.99.918 1.22 1.869-1.573 3.663-1.573 3.663.286.277 1.157 1.14 2.447 2.421M52.497 47.082a535.186 535.186 0 002.744 2.716c.655-1.302 2.133-1.943 3.459-1.546 1.374.411 2.157 1.808 2.036 2.954-.168 1.589-2.11 3.04-4.438 2.556.405 1.513.068 3.062-.933 3.995-1.654 1.54-4.33.614-4.99-.918-.47-1.088-.193-2.297 1.438-3.505-.258-.25-.991-.975-2.078-2.055"/>
  </g>
</svg></td>
</tr>
    </tbody>
</table>
                </div>
            </main>
            <footer>
                <div class="footer">Wednesday, January 20 2021 02:42:00</div>
            </footer>
        </div>
    </body>
</html>
"""
