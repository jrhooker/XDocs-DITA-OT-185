var n = document.querySelectorAll("div[style='browsesequence']>div");

var out = "<table><tr>";

function WriteHTML(nodelist) {
    for (var i = 0, j = nodelist.length; i < j; i++) {
        out = out + "<td>" + nodelist[i].innerHTML + "</td>";
    }
    out = out + "</tr></table>";    
    return out;
}

console.log("real childnodes:", WriteHTML(n));

function BrowseSeqNodes(nodelist) {
    var bNodes =[];
    for (var i = 0, j = nodelist.length; i < j; i++) {
        if (nodelist[i].nodeType == 1) {
            bNodes.push(nodelist[i]);
        }
    }
    return bNodes;
}

var p = document.getElementById("browsesequence");

p.innerHTML = out;