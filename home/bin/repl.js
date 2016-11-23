#!/usr/bin/env node
// See http://www.2ality.com/2011/11/node-repl-start.html

var repl = require('repl');
var context = repl.start('> ').context;

context.lo = require('lodash');
context.u = require('updeep');
