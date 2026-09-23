function Table(el)
  return {
    pandoc.RawBlock("html", '<div class="table-wrap">'),
    el,
    pandoc.RawBlock("html", "</div>"),
  }
end
