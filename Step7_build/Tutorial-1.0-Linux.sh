#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is the open source License.txt file introduced in
CMake/Tutorial/Step7...

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +152 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� u�c �\|E����dx)�ye��TdB���<8���t�Y'3a���a�Y���ht�4��{q]OW�3{����]7����rp/{��f����'�����ꩮ����=������������5_U0���
p���*-.!u��X��]T�*q��%Ţ�]PZZ��i��BSB��׃cȝ/��C�$!Hڿ.�F�A_�<n69��3X%EE��_�v'ۿ����D�xa����b��6+�7{<��H���c�/c���M1�1i��0�4Ê�7ykj+�l���6l��cTn�.]���+Wm�*��&�oW�W4��_�S�+�a?n������B2�]%�"4��K���)B o)b���Ψ��pmK�O�ǯF.�
���.p���.E@�/����<�3���0��F�qQz��$a�����Ɖ+Dcp�ܻxa�݁6x5�=F�|�!��%�S% �v����9#+�Ў�	�^ZXB�ӻ��&���&%�eY����Gy�N�K]ǥ���yS���yh�[��N@��n��N�9��(v��9&#P�`�6�e�;�k��sR���ݡaL�gj�[!ʖH�����X-�ɰ�yO ��Wp�i#��4Sݨ�ƼŇO�m;L��rE�B�j4)����U��V,3bmq��R7�)/< u���%���`L)n�����~bB�}��DB3Z��3�����%]�g�⣝�g���w��&p$��Q�5�� ғ����K�3��s����>�f����^ߧk~�POޝ���v���}�����"����z�c�>�gi��������Һ����c
��RQ�Ոج�ZE�y��Pb0T�����+"(�����'���iJ� ��}���������//�N\\��q��v:]��8f�{

���%���r������h� �N�� T��mannvN��+�v��mT��)�{l哳�w	P��@�oL��
E��[H�l6�G[��a�,�n:��a�g�`�8�$N5^��3R���7A�@�
���C�M�8����VB�	�i��T߷��>|�3���;���9��WZ�����Z��-p�a ���&��֠�W���_?�hܯjQ+e9AC�EnY��j5�ɠ
��C�+�/����`��7mY[�	&�7ȕ��c	eQ�ĵ�B��Z���7�����X��뭁Xa�/s��_K��N�����z.[**j�ur]��M^Yӫ��J���S����tsm$�VW��Fje��2��0�RT	����d9��Ͱp�R��iB�6��S�6X���	EM�z�&�Wpx��8����|��$��Hp$���-_
�)����1����	�"g�k�9<@�,���	�`p��Y�������%��uD���z=�����ȳ���L�v�����`�1�!=�{�3�o�3��tH�E�]�i���t^���Tp�v���-�jT���.��|N��U��Tp6�b�h�Es��F}���iiQ�P8Q'|8��	�;��qgk4ҪD��$��,7F}-
� �:��pZ��G�����p��lBI%O&i�3w��n��!�r���ˉN>}���^�w�d1K����;Í@|�9vs������?A���P�e����@��R$��.p���	
7������jj��<$���|}�)0��$}���w��;L�O"<��I ����Fa��?J
��x�Iz��U�Q�jw�y��T��������<��CC0�s�� ��w)j�3���c��/**,bۿ �aIqqz��R~u�NV�<�4�C�!O2�~;L�Ep~2�O�ڌ���v�n��yJW(e�����$��FJ?AQ�L�����M��	��v����P݌�׀������e��H�Y�?k���/pW��l%��S:�(��59�ү�u�<
������WM�����o#��}��ߔ�
�ykH~V���-J��Q��hE(�
��m�m+K�K�����@��l��f��x��~%ى��g�s�cm?���s�|����%(@�ٷ$t?�_�{��tT9�2�7�ܪ^�ڴ�>>��3�	��?��k�G��w�����B���v;������B�C�:-�j���E��"�r����
�|�[�gZ��Y`�϶�7깠ã�tU�rSK$�V,���J(Q�)S�h]Uy(V���3�1���� ��U����֗Yr�U�dYm�F�]�P0 ��Mq�6�W�ТZ)ZBks���"�'n2�[�-w{aښ������\�j����&�*�X$�Pw˻\zA�I��_ܘb,B��:�/�j�-�/��h@D�4�Q_�I�9ׇ��r��B2��z�D,����w���a�J'Z��N#+�h8"�"~�b�J��v��|�������15�_���%�m�C��s#ί����e��J�֭ek+e����T��.b�n��h�+L�8���v������_A��%�gg�e]6�D��m�y�z��I�){D_}��'I<�����h��-��K�AO��~���6��y�I��-��NFO�3��e��_�]��s�Pi�үw�|%����f���L�s��@sp�����p�����d��H��(fp���(�������C�Ώ�>��G�re�Y� �@�'��	�W����=���B!18��P���{�Vg3����
P3�O`�Vg}��|[.�e�}>��{|
��2x��1�T���3x?��`�~H�t������y"G����
8m�Pm��R�9��D�x"�O&��I�UX{�|�w�D�����uގ���|���L�?��Y��K�1�S�s0���	����O�|��O¼[�s1?_�'c~��O����y����am�u��X���?�7��s�q��w��g���_��_p��8�Y��������9~/Ƿ����ʮc�I]�H��9R]�u�%�_��>3o��7:�Ҿ�!.8�k�i!�Ug®wS���&$���@r�
叡���o ���5"�`�tp�.	�K�Ω3��k����P#���G�u�~f	�����o�/�븚+u�΂Ɇ��v��~=��	�´����#��Q--�]�J]�ԝq�b��;��lTȻ�⻽=R7q�����+͇�h�L���U�|I �DD�؝����P�*$�=s�r���mlȥ�]O/�D�欦,i
T���4������J_X�+�"�U��6�>��,�u��"G�_������ػ�!��V?T�ݿ`��k���Ϝ�RX�K�׏�Æ��fT� 4p�$Z��e�¡3�D��#ZH/Ph�^�����Z!�i�^�Ǡ�llw�p@Z67�z�{�xR�z��,A���� 6>��D����w�:����.#�Ԃ�#s�R��vvus۾T����3������>
;�,�(J��VĈ�u��6��{�����:�����gC%����1��Cx$��ɾʂ�����FR?�=���؏�q�'M�c
�? m꟒����������[���B{����h��8F�� �8*��>�EZ2\�-�]�N�]����o�ٸ����͂���Ӛ#v�:�� N~TZs��'u9�����V��So��k]�޼d/�r/��{����|�G�|W�B���簾��9��jMW��.��6��M��Sz�9���~N���/�:/g,��7���G��,~k����j�):�g�3���`�wu�V�7��}J����ZR���xP�x�K�Q�w�&�9:��N���ob�����:C���MJ4��E��1_�r��p��A���fE������DȾ�`LL�T� ����ї$�$o����1�HA��(�&}��>�H��5�>^a1OA*���>I$��S��Az���������&���~�i"��!���z�G � ��V�&�|��-�����˸Wë^�hy�)��)�6�M�#���s��«P�ȓ���]�E8���8�Ћ�^�?J$� @߅Q�����ބ-�~��y ̥�^Ml��l),[�a���v��W�t=����26�m7����l��"
��`�7j�Ȇ����0~>��x�.�v|�?��j�ɣ0��7�u������]-��v.|j������\?
��pyY?�eޕ~b�<aC6�~�&n���p�-ugJ:�C:�C:�C:�C:\�@�Q��	�7��%��In7���*�u���N}z�^�B�b���~P���B���;�'�D���
}{�A�V��
�=C}/�$<�����>*(P����K���t�����C}Y&��v7���G��?�>Kh�t��H�ᩝ#��C�O�b�US�k>�H{{�&t���v�Ch���z��!BG�G q^q*��,�R�50�wz�<��2X�0h����v�M��G��o+��*���	>��8߹��,i
���r}|���G�n��a������'-��)��2Dc�O�y���?H��d"��L4�΋t�Z ����"�-�]<ۘo>�w7_Z�W��t� ��s�:A�F��Є��J߭��χ4�c��8Z3��x�ǈ��D}hN�6ɧ�G� 7g�e?+��>M��G/צ�O���Ꟶ�����`	�oK�D�BO?SmsR�+���,��@|>�C�����M՟�4��B�?X��-�+2����L�~�B~m�&�򀣻ѫ2��n�wZ�?@�-7�h�eh�����s���-�_���C��-��\�[f�gj�*H�}�?�i��5������2�7�|f���U�6<�e�O��B����Y������I}��2_U���ޒm�?j!�s���x����l�y��A�?��� ˾����� bj����ɍ��"���: $"7�"��P#ј싷��5��J >aM%��}P;)AV�jt7�GȁxK�n�����
DT%[J/�)/x {���!0rEMY�W�n^�����7��^��Һ �۶������nC����|܄�}��U�����%�X_e ����z�\ruE�\���-WW���Z�
d�cm�h�]Ms��Z�.E�J�3Q�j	�r<��9�q�^��6@7k+�7찙��ߜg'�1�n]�K��fgTit���A�(u������Q1V��%��.`�Wn� $���������:7n��$����(����آ�|�|�3;�R;rZ�����k�$T��o �V�JSΔx��ʆM.�w�}L\6�b�Z�*��/�ޚ��k��[+����Y\������c�7�S��]ϰ3�C�F����F�-2޳]>˸7��2L��]��:���t�;�u ��V��t�!����^#p\�/����a��Fը�K�00r����]kH��%�n�MrS���̄�D�P&z����&9���/+m~�U��O0�ܔ|7�V�Z�~ÑO�d�/�:{R��94�Ġ�Sv��>y�SvJ������9y�l�J.=]��E����O�MO�)]Lp�������#MO�')�G"��5��t����wRJ�7i��'��iz�^Hi	g���{��Iy�IiH�o����:����(�t}��?Z��I����뭔v0�g��p��q�^�uh���K/:���U8�Ɠ\z�T#�O����s�=S��op>�|�iFz3���Ğ_r��:��9y��^�IW���s�|�y�Kou^�U�os�W�7�+�#����s���N�������o��8fq��)mvA��ҏW����˧��{~��THz3���h?xOɣ끋ɩY��������!�L��)k"������u�6WR?<F,�O���q�`B�Ni{���!����\�yOi�/ը�k@��X������s	�����`�Ox � p  