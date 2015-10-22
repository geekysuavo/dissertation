#!/bin/bash

if [ "${NAME}" == "" ]; then
  NAME="bworley"
fi

echo "Creating a lo-res mirror directory..."

rm -rf ${NAME}-lo
install -d ${NAME}-lo
cp -R *.sty *.dtx *.ins *.tex *.bib Makefile figs ${NAME}-lo/
pushd ${NAME}-lo >/dev/null

echo "Down-converting high-res figures..."

for pair in $(sed -nf ../${NAME}-lo.sed *.tex); do
  f=$(echo ${pair} | cut -f 1 -d ':')
  w=$(echo ${pair} | cut -f 2 -d ':')

  n_orig=$(identify ${f} | awk '{print $3}' | cut -f 1 -d x)
  r_orig=$(echo "scale=6;${n_orig}/${w}" | bc)

  cvargs="-background white"
  cvargs="${cvargs} -density 300x300 -units PixelsPerInch"
  cvargs="${cvargs} -quality 80"

  if [ "$(expr ${r_orig} \> 300.0)" == "1" ]; then
    n_adj=$(echo "scale=6;${w}*300.0" | bc)
    if [ ! "$(echo ${n_adj} | grep '.' | wc -c)" == "0" ]; then
      n_adj=$(echo ${n_adj} | cut -f 1 -d '.')
    fi

    cvargs="${cvargs} -filter Lanczos -resize ${n_adj}"
  fi

  g=$(echo ${f} | sed -e 's,png$,jpg,')
  echo "  ${f} => ${g}"

  convert ${cvargs} ${f} ${g}
done

echo "Resolving broken figure links..."

for f in *.tex; do
  sed -e 's,\.png,.jpg,g' -i ${f}
done

echo "Rebuilding output file..."
make again

popd >/dev/null
cp ${NAME}-lo/${NAME}.pdf ${NAME}-lo.pdf
rm -rf ${NAME}-lo

