String handleList<T>(List<T> list) =>
    list.isEmpty ? '' : '(${list.join(', ')})';
