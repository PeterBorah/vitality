util = require('ethereumjs-util');

module.exports = {
  tokenize: function(code) {
   return code.replace(/\(/g, '( ')
         .replace(/\)/g, ' ) ')
         .replace(/\,/g, ' , ')
         .replace(/\;/g, ' ; ')
         .trim()
         .split(/\s+/);
  },

  getIntermediate: function(tokens, list, size) {
    if (list === undefined) {
      return this.getIntermediate(tokens, [], 0);
    } else {
      var token = tokens.shift();
      if (token === undefined) {
        return list;
      } else if (token.slice(0, 2) == "0x") {
        list.push({type: "identifier", value: web3.toDecimal(token)});
        list.push({type: "argNumber", value: 0});
        return this.getIntermediate(tokens, list, size + 2);
      } else if (token.slice(-1) == "(") {
        var id = {type: "identifier", value: token.slice(0, -1)};
        var argNum = {type: "argNumber", value: 1}
        var interiorList = this.getIntermediate(tokens, [id, argNum], 0);
        list = list.concat(interiorList);
        size += interiorList.length
        return this.getIntermediate(tokens, list, size);
      } else if (!isNaN(parseInt(token))) {
        list.push({type: "identifier", value: "Number" })
        list.push({type: "argNumber", value: 0});
        list.push({type: "identifier", value: "new" })
        list.push({type: "argNumber", value: 1});
        list.push({type: "argSize", value: 2});
        list.push({type: "identifier", value: token })
        list.push({type: "argNumber", value: 0});
        return this.getIntermediate(tokens, list, size + 7);
      } else if (token === ")") {
        var num = list[1].value;
        var argSize = {type: "argSize", value: size}
        list.splice(1 + num, 0, argSize)
        return list;
      } else if (token === ",") {
        var num = list[1].value;
        var argSize = {type: "argSize", value: size}
        list.splice(1 + num, 0, argSize)
        list[1].value += 1;
        return this.getIntermediate(tokens, list, 0);
      } else {
        list.push({type: "identifier", value: token});
        list.push({type: "argNumber", value: 0});
        return this.getIntermediate(tokens, list, size + 2);
      }
    }
  },

  getBytecode: function(intermediate) {
    return intermediate.map(function(x) {
      return util.bufferToHex(util.setLengthLeft(util.toBuffer(x.value), 32));
    });
  },

  parse: function(code) {
    return this.getBytecode(this.getIntermediate(this.tokenize(code)));
  }
}
