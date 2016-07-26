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
      } else if (token.slice(-1) == "(") {
        var id = {type: "identifier", value: token.slice(0, -1)};
        var argNum = {type: "argNumber", value: 1}
        var interiorList = this.getIntermediate(tokens, [id, argNum], 0);
        list = list.concat(interiorList);
        size += interiorList.length
        return this.getIntermediate(tokens, list, size);
      } else if (!isNaN(parseInt(token))) {
        list.push({type: "number", value: parseInt(token) })
        return this.getIntermediate(tokens, list, size + 1);
      } else if (token[0] == "'") {
        list.push({type: "string", value: token.slice(1, -1)})
        return this.getIntermediate(tokens, list, size + 1);
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
        return this.getIntermediate(tokens, list, size + 1);
      }
    }
  }
}
