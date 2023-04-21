const path = require('path');
const fs   = require('fs');
const os   = require('os');




// FILE
// ----

function readFile(pth) {
  var d = fs.readFileSync(pth, 'utf8');
  return d.replace(/\r?\n/g, '\n');
}

function writeFile(pth, d) {
  var d = d.replace(/\r?\n/g, os.EOL);
  fs.writeFileSync(pth, d);
}




// Number columns in a CSV file.
function numberColumns(pth) {
  var head = readFile(pth).replace(/\n[\s\S]*/, '').trim();
  var cols = head.split(',').map(c => c.replace(/^\"(.*?)\"$/), '$1');
  var pads = Math.ceil(Math.log10(1 + cols.length)), a = '';
  for (var i=0; i<cols.length; ++i)
    a += '# ' + (i+1).toString().padStart(pads, '0') + '. ' + cols[i] + '\n';
  return a;
}


// Slice a certain number of rows in a CSV file.
function sliceRows(pth, begin, end) {
  var data = readFile(pth);
  var head = data.replace(/\n[\s\S]*/, '').trim();
  var body = data.replace(head, '').trim();
  var rows = body.split('\n');
  return head + '\n' + rows.slice(begin, end).join('\n') + '\n';
}


// Slice a certain number of rows in CSV files.
function sliceRowsAll(src, dst, begin, end) {
  fs.mkdirSync(dst, {recursive: true});
  for (var f of fs.readdirSync(src))
    writeFile(path.join(dst, f), sliceRows(path.join(src, f), begin, end));
}


function main(a) {
  if (a[2]==='number-columns')   console.log(numberColumns(a[3]));
  else if (a[2]==='slice-rows')  console.log(sliceRows(a[3], parseFloat(a[4]), parseFloat(a[5])));
  else if (a[2]==='slice-rows-all') sliceRowsAll(a[3], a[4], parseFloat(a[5]), parseFloat(a[6]));
}
main(process.argv);
