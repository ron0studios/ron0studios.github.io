GDPC                                                                               <   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex�$      U      -��`�0��x�5�[@   res://.import/triangle.png-53a0c5b2abae92a9e7f23d30d12f32c2.stex0F            J��{,�}�:tU.AT~   res://cam.gd.remap  �O             %c�� ���-��:M   res://cam.gdc   �      ,      h������TB֙�   res://default_env.tres  �      �       um�`�N��<*ỳ�8   res://edge.gd.remap �O             �%�����k��Y�1��   res://edge.gdc  �	      �      �'_}Z�Ii���Q��   res://edge.tscn `      @      ��~8����N\0W�   res://graphnode.gd.remapP      $       tÇ>�㩥P
OFt�   res://graphnode.gdc �      �
       2~�JDC��}�r��   res://graphnode.tscn@      H      ��8doo�l�:��?   res://icon.png  `P      �      G1?��z�c��vN��   res://icon.png.import   �1      �      �����%��(#AB�   res://main.gd.remap @P             ֤�\n�������Dݮ�   res://main.gdc  p4      �      ��t��;A�u������   res://main.tscn A            ao��D 穂q����   res://project.binaryP]            ���{�u"�����!   res://triangle.png.import   @M      �      T(uw��Q� ��{q        GDSC         %   �      �����ׄ򶶶�   �����ض�   ����ݶ��   ���Ѷ���   �����϶�   �����¶�   ����¶��   ����¶��   ����������������Ҷ��   ���۶���   ���������������Ŷ���   ����׶��   ����������������������Ҷ   ����������������������¶   ��������������������ض��   �����¶�   �������Ӷ���   ��������������������ض��   ������Ҷ          
   scrolldown    �������?      scrollup  �������?      lmb                                                           	      
                            '      0      4      =      A      B      I      T      X      c      g      i      j      k      l      m      n      u       }   !   �   "   �   #   �   $   �   %   3YYYYYY;�  V�  Y;�  Y;�  YYY0�  PQV�  -Y0�  P�  QV�  &�  T�  P�  QV�  �	  �  �  '�  T�  P�  QV�  �	  �  �  Y0�
  P�  QV�  &�  �  T�  P�  QV�  �  �  �  &�  T�  P�  Q�  V�  �  �  -YYYYYY0�  P�  QV�  &�  �  4�  V�  T�  �  T�  �	  �  &�  4�  �  T�  V�  �  �  �  -Y`    [gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
             GDSC   %      5   �     ���ӄ�   �����������۶���   ���������ٶ�   �����϶�   ����������Ŷ   ��¶   ߶��   �������¶���   ������Ŷ   ������¶   ׶��   Զ��   ն��   ����ض��   �������������������϶���   �����������䶶��   �������ⶶ��   ����¶��   ����޶��   �������Ŷ���   ����׶��   �������Ӷ���   �������Ӷ���   ����������Ŷ   �����Ӷ�   ���������Ӷ�   ���������������������ض�   �����Ŷ�   �������������������ض���   ������Ҷ   �����������ٶ���   �������ض���   �������ض���   �����������������������ض���   ������������������������ض��   ��������������ض   �������������¶�            modulate             ?                   Z                                              
         	      
                                 )      -      /      0      =      g      n      o      u      �      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '     (     )     *     +   )  ,   ?  -   I  .   Z  /   ]  0   f  1   g  2   �  3   �  4   �  5   3YYYYYY;�  Y;�  YYY0�  PQV�  -YY0�  P�  QV�  )�  T�  T�  V�  �  �  �  -YY0�	  P�
  R�  R�  QV�  W�  T�  PR�  R�  P�
  R�
  R�
  RQR�  P�  R�  R�  RQR�  R�  T�  R�  T�  Q�  W�  T�  PQYY0�  PQV�  W�  T�  PR�  R�  P�  R�  R�  RQR�  PRRRQR�  R�  T�  R�  T�  Q�  W�  T�  PQ�  �  YYY0�  P�  QV�  &W�  T�  T�
  �  V�  W�  T�  T�
  S�  &�  4�  V�  &�  �  �  �  V�  &�  �  V�  )�  �K  P�X  P�  T�  QQV�  &�  T�  L�  M�  V�  �  T�  T�  P�  Q�  T�  PQ�  -�  &T�  PQV�  �  LM�  T�  �  T�  �  �  LM�  P�  R�  Q�  �  LM�  P�  R�  QT�  P�  P�  T�  QQ�  W�  T�  �  LM�  W�  T�   �+  P�  Q�  P�  T�  Q�  (V�  �  LM�!  PQ�  �  W�  T�  �  LM�  P�  R�  QT�  P�  P�"  PQQQ�  W�  T�   �+  P�  QPT�#  �  P�  R�  QQT�$  P�"  PQQ�  -Y`   [gd_scene load_steps=5 format=2]

[ext_resource path="res://edge.gd" type="Script" id=1]
[ext_resource path="res://triangle.png" type="Texture" id=2]

[sub_resource type="Shader" id=1]
code = "shader_type canvas_item;

void fragment()
{
	COLOR = texture(TEXTURE,UV);
	//COLOR *= 999.0f;
	if(COLOR.b > 0.0f)
	{
		COLOR.a = 0.0f;
	}
}"

[sub_resource type="ShaderMaterial" id=2]
shader = SubResource( 1 )

[node name="edge" type="Line2D"]
z_index = -10
points = PoolVector2Array( 16, 16, 16, 16 )
width = 5.0
default_color = Color( 1, 0, 0, 1 )
joint_mode = 2
begin_cap_mode = 2
end_cap_mode = 2
script = ExtResource( 1 )

[node name="triangle" type="Sprite" parent="."]
modulate = Color( 1, 1, 1, 0 )
material = SubResource( 2 )
scale = Vector2( 0.125, 0.125 )
texture = ExtResource( 2 )

[node name="Tween" type="Tween" parent="."]
GDSC   -      S   �     ����ڶ��   ����ݶ��   ����������Ӷ   ����������Ŷ   ����Ӷ��   �����϶�   ����޶��   ����ض��   �������������������϶���   �����������䶶��   �������ⶶ��   ����¶��   �������Ŷ���   ����׶��   ����ڶ��   ���¶���   ����¶��   ���������������������Ҷ�   ���������¶�   ������Ѷ   ���Ӷ���   �������Ӷ���   �����������۶���   ���������ٶ�   ������������������������ض��   ��������Ҷ��   ������������   �����Ҷ�   ����������������Ҷ��   ����������������������Ҷ   �����������ض���   ���������Ŷ�   ߶��   ����������������������Ҷ   ���������������������Ҷ�   ������������������¶   ����¶��   ��Ŷ   ��������������������ض��   ����������ݶ   �����������ζ���   �����������   ���������Ӷ�    ����������������������������Ҷ��   ���������¶�                   self_modulate         ?      rmb       res://edge.tscn             lmb             mmb       tween_all_completed       _on_Tween_tween_all_completed                                                       	      
               $      (      *      +      1      [      b      c      d      e      f      m      w      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %     &     '   	  (     )     *   #  +   '  ,   +  -   9  .   ;  /   <  0   B  1   H  2   T  3   Z  4   `  5   e  6   g  7   h  8   n  9   x  :   |  ;   ~  <     =   �  >   �  ?   �  @   �  A   �  B   �  C   �  D   �  E   �  F   �  G   �  H   �  I   �  J   �  K   �  L   �  M   �  N   �  O   �  P   �  Q   �  R   �  S   3YYYYYY;�  Y;�  Y;�  LMY;�  �  YY0�  PQV�  �%  PQ�  -YY0�  PQV�  W�  T�  PR�  R�  P�  R�  R�  R�  QR�  P�  R�  R�  R�  QR�  R�  T�	  R�  T�
  Q�  W�  T�  PQ�  �  YYY0�  P�  QV�  W�  T�  �>  P�  Q�  &�  T�  P�  Q�  V�  &�  PQT�  PQT�  V�  ;�  �L  P�  QT�  PQ�  �  T�  �  �  T�  �  PQ�  �  P�  Q�  �  PQT�  PQT�  �  �  �  PQT�  PQT�  �  �  (V�  &�  PQT�  PQT�  T�  V�  �  PQT�  PQT�  �  �  PQT�  PQT�  T�  �  �  PQT�  PQT�  T�  T�  T�  PQ�  �  �  &�  �  T�  P�  QV�  �  �  �  &�  T�  P�  Q�  V�  �  �  &�  V�  �  P�  PQ�  P�  R�  QQ�  -YY0�  PQV�  )�   �  V�  ;�  �L  P�  QT�  PQ�  �  T�  �  �  T�  �   �  �  P�  Q�  -YY0�!  PQV�  &�  T�  P�  QV�  �  �  �  -YYY0�"  PQV�  �  �  -YYY0�#  P�$  QV�  &�  T�  P�	  QV�  �  PQT�  PQT�%  PQ�  &�$  4�&  V�  &�$  T�'  �$  T�(  �)  V�  T�*  PQ�  -YYYYY0�+  PQV�  �  �  W�  T�,  P�
  RR�  Q�  -Y`              [gd_scene load_steps=3 format=2]

[ext_resource path="res://graphnode.gd" type="Script" id=1]

[sub_resource type="StyleBoxFlat" id=1]
bg_color = Color( 0.294118, 1, 0, 1 )
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color( 0.0509804, 0.294118, 0, 1 )
corner_radius_top_left = 90
corner_radius_top_right = 90
corner_radius_bottom_right = 90
corner_radius_bottom_left = 90
shadow_offset = Vector2( 3, 3 )
anti_aliasing = false

[node name="Panel" type="Panel"]
margin_left = -16.0
margin_top = -16.0
margin_right = 16.0
margin_bottom = 16.0
rect_pivot_offset = Vector2( 16, 16 )
custom_styles/panel = SubResource( 1 )
script = ExtResource( 1 )
__meta__ = {
"_edit_use_anchors_": false
}

[node name="Tween" type="Tween" parent="."]

[node name="Label" type="Label" parent="."]
self_modulate = Color( 0, 0, 0, 1 )
margin_left = -48.0
margin_top = -32.0
margin_right = 80.0
margin_bottom = -2.0
align = 1
__meta__ = {
"_edit_use_anchors_": false
}
[connection signal="gui_input" from="." to="." method="_on_Panel_gui_input"]
[connection signal="mouse_entered" from="." to="." method="_on_Panel_mouse_entered"]
[connection signal="mouse_exited" from="." to="." method="_on_Panel_mouse_exited"]
[connection signal="tween_all_completed" from="Tween" to="." method="_on_Tween_tween_all_completed"]
        GDST@   @           9  PNG �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx�ݜytTU��?��WK*�=���%�  F����0N��݂:���Q�v��{�[�����E�ӋH���:���B�� YHB*d_*�jyo�(*M�JR!h��S�T��w�߻���ro���� N�\���D�*]��c����z��D�R�[�
5Jg��9E�|JxF׵'�a���Q���BH�~���!����w�A�b
C1�dB�.-�#��ihn�����u��B��1YSB<%�������dA�����C�$+(�����]�BR���Qsu][`
�DV����у�1�G���j�G͕IY! L1�]��� +FS�IY!IP ��|�}��*A��H��R�tQq����D`TW���p\3���M���,�fQ����d��h�m7r�U��f������.��ik�>O�;��xm��'j�u�(o}�����Q�S�-��cBc��d��rI�Ϛ�$I|]�ơ�vJkZ�9>��f����@EuC�~�2�ym�ش��U�\�KAZ4��b�4������;�X婐����@Hg@���o��W�b�x�)����3]j_��V;K����7�u����;o�������;=|��Ŗ}5��0q�$�!?��9�|�5tv�C�sHPTX@t����w�nw��۝�8�=s�p��I}�DZ-̝�ǆ�'�;=����R�PR�ۥu���u��ǻC�sH`��>�p�P ���O3R�������۝�SZ7 �p��o�P!�
��� �l��ހmT�Ƴێ�gA��gm�j����iG���B� ܦ(��cX�}4ۻB��ao��"����� ����G�7���H���æ;,NW?��[��`�r~��w�kl�d4�������YT7�P��5lF�BEc��=<�����?�:]�������G�Μ�{������n�v��%���7�eoݪ��
�QX¬)�JKb����W�[�G ��P$��k�Y:;�����{���a��&�eפ�����O�5,;����yx�b>=fc�* �z��{�fr��7��p���Ôִ�P����t^�]͑�~zs.�3����4��<IG�w�e��e��ih�/ˆ�9�H��f�?����O��.O��;!��]���x�-$E�a1ɜ�u�+7Ȃ�w�md��5���C.��\��X��1?�Nغ/�� ��~��<:k?8��X���!���[���꩓��g��:��E����>��꩓�u��A���	iI4���^v:�^l/;MC��	iI��TM-$�X�;iLH���;iI1�Zm7����P~��G�&g�|BfqV#�M������%��TM��mB�/�)����f����~3m`��������m�Ȉ�Ƽq!cr�pc�8fd���Mۨkl�}P�Л�汻��3p�̤H�>+���1D��i�aۡz�
������Z�Lz|8��.ִQ��v@�1%&���͏�������m���KH�� �p8H�4�9����/*)�aa��g�r�w��F36���(���7�fw����P��&�c����{﹏E7-f�M�).���9��$F�f r �9'1��s2).��G��{���?,�
�G��p�µ�QU�UO�����>��/�g���,�M��5�ʖ�e˃�d����/�M`�=�y=�����f�ӫQU�k'��E�F�+ =΂���
l�&���%%�������F#KY����O7>��;w���l6***B�g)�#W�/�k2�������TJ�'����=!Q@mKYYYdg��$Ib��E�j6�U�,Z�鼌Uvv6YYYԶ��}( ���ߠ#x~�s,X0�����rY��yz�	|r�6l����cN��5ϑ��KBB���5ϡ#xq�7�`=4A�o�xds)�~wO�z�^��m���n�Ds�������e|�0�u��k�ٱ:��RN��w�/!�^�<�ͣ�K1d�F����:�������ˣ����%U�Ą������l{�y����)<�G�y�`}�t��y!��O@� A� Y��sv:K�J��ՎۣQ�܃��T6y�ǯ�Zi
��<�F��1>�	c#�Ǉ��i�L��D�� �u�awe1�e&')�_�Ǝ^V�i߀4�$G�:��r��>h�hݝ������t;)�� &�@zl�Ұր��V6�T�+����0q��L���[t���N&e��Z��ˆ/����(�i啝'i�R�����?:
P].L��S��E�݅�Á�.a6�WjY$F�9P�«����V^7���1Ȓ� �b6�(����0"�k�;�@MC���N�]7 �)Q|s����QfdI���5 ��.f��#1���G���z���>)�N�>�L0T�ۘ5}��Y[�W뿼mj���n���S?�v��ْ|.FE"=�ߑ��q����������p����3�¬8�T�GZ���4ݪ�0�L�Y��jRH��.X�&�v����#�t��7y_#�[�o��V�O����^�����paV�&J�V+V��QY����f+m��(�?/������{�X��:�!:5�G�x���I����HG�%�/�LZ\8/����yLf�Æ>�X�Єǣq���$E������E�Ǣ�����gێ��s�rxO��x孏Q]n���LH����98�i�0==���O$5��o^����>6�a� �*�)?^Ca��yv&���%�5>�n�bŜL:��y�w���/��o�褨A���y,[|=1�VZ�U>,?͑���w��u5d�#�K�b�D�&�:�����l~�S\���[CrTV�$����y��;#�������6�y��3ݸ5��.�V��K���{�,-ւ� k1aB���x���	LL� ����ңl۱������!U��0L�ϴ��O\t$Yi�D�Dm��]|�m���M�3���bT�
�N_����~uiIc��M�DZI���Wgkn����C��!xSv�Pt�F��kڨ��������OKh��L����Z&ip��
ޅ���U�C�[�6��p���;uW8<n'n��nͽQ�
�gԞ�+Z	���{���G�Ĭ� �t�]�p;躆 ��.�ۣ�������^��n�ut�L �W��+ ���hO��^�w�\i� ��:9>3�=��So�2v���U1z��.�^�ߋěN���,���� �f��V�    IEND�B`�           [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
GDSC   8      _   b     ���ӄ�   ��������������Ŷ   ������Ѷ   ������������   �����Ŷ�   �����¶�   �������Ҷ���   ζ��   ׶��   ������Ӷ   ����������Ӷ   ���ζ���   ���϶���   ����Ӷ��   ������Ӷ   �������Ӷ���   ����Ŷ��   ��������Ҷ��   �������������������ض���   �������Ӷ���   �����޶�   �����϶�   ߶��   ��������Ҷ��   �����������ض���   ������¶   ܶ��   ����������Ŷ   �����Ҷ�   ����������ڶ   �����¶�   ����¶��   ����¶��   �������������Ҷ�   ����������   ���������Ӷ�   ��Ŷ   ����¶��   �������Ҷ���   ���¶���   �������Ӷ���   �����������Ķ���   ����޶��   ���������ٶ�   ������¶   ������������Ӷ��   ����������������������¶   ��������������������ض��   ����������ݶ   �����������ζ���   �����������   ��������������¶   ������������������������ض��   ������������������������Ҷ��   �����Ӷ�   ���������Ӷ�                               res://graphnode.tscn   
      d         initconnections    
   init_edges              timeout       ?   	   completed                                                          
         	      
                     $      )      /      2      3      A      M      S      [      f      g      n      p      q      r      x      |      }      ~          !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0   �   1   �   2      3     4     5     6     7     8     9     :   "  ;   #  <   $  =   0  >   5  ?   <  @   @  A   N  B   T  C   [  D   m  E   }  F   �  G   �  H   �  I   �  J   �  K   �  L   �  M   �  N      O     P     Q     R     S     T     U   )  V   6  W   >  X   M  Y   O  Z   P  [   Q  \   X  ]   ^  ^   `  _   3YYYYYYB�  Y;�  Y;�  Y;�  �  Y;�  �  YY0�  P�  QV�  ;�  �  �  �  T�	  PQ�  .�  YY0�
  P�  R�  R�  �  QV�  ;�  �L  P�  QT�  PQ�  �  T�  �  �  W�  T�  P�  Q�  �  T�  �  P�  R�  QYY0�  P�  QV�  -YYY0�  PQV�  �%  PQ�  �  �  �  �  �  �  �  )�  �K  P�  QV�  �
  P�  �  RP�  �  Q�  R�  �  Q�  �  �  ;�  LM�  )�  W�  T�  PQV�  T�  P�  R�  R�  Q�  )�  �  PW�  T�  PQQV�  �%  PQ�  &�  �  �  �  T�  �X  P�  T�  Q	�  �  �  V�  �  T�  P�  Q�  �  T�  T�  P�  Q�  �  P�  Q�  Y�  -YY0�  P�  QV�  &�   T�!  P�"  QV�  �  �  &�  V�  �  T�#  PQYYY0�$  P�%  R�&  LMQV�  ;�'  �  &�&  LMV�  �'  �	  �  AP�(  PQT�)  P�  QR�
  Q�  �%  T�*  PQ�  �&  T�  P�%  Q�  )�  �K  P�  R�X  P�%  T�  PQQQV�  &�%  T�  PQL�  MT�+  �&  V�  AP�(  PQT�)  P�  QR�
  Q�  �%  T�  PQL�  MT�,  P�  R�  R�  Q�  AP�$  P�%  T�  PQL�  MT�+  R�&  QR�  Q�  AP�(  PQT�)  P�  QR�
  Q�  �%  T�  PQL�  MT�,  P�  R�  R�  Q�  &�'  �	  V�  AP�(  PQT�)  P�  QR�
  Q�  )�  W�  T�  PQV�  �  T�-  �  P�  R�  R�  R�  Q�  -YYY0�.  P�  QV�  &�  4�/  V�  &�  T�0  �  T�1  �2  V�  ;�  �L  P�  QT�  PQ�  �  T�  W�  T�3  PQ�  �  W�  T�  P�  Q�  �  T�  �4  PQ�  P�  R�  Q�  -YYY0�5  P�  QV�  �6  T�7  �  �  -Y`               [gd_scene load_steps=3 format=2]

[ext_resource path="res://cam.gd" type="Script" id=2]
[ext_resource path="res://main.gd" type="Script" id=3]

[node name="interface" type="Node2D"]
script = ExtResource( 3 )

[node name="viewpoint" type="Camera2D" parent="."]
position = Vector2( 512, 300 )
current = true
script = ExtResource( 2 )

[node name="CanvasLayer" type="CanvasLayer" parent="viewpoint"]
layer = -10

[node name="ColorRect" type="ColorRect" parent="viewpoint/CanvasLayer"]
margin_right = 1024.0
margin_bottom = 608.0
color = Color( 0.807843, 0.807843, 0.807843, 1 )
__meta__ = {
"_edit_use_anchors_": false
}

[node name="GUI" type="CanvasLayer" parent="viewpoint"]
layer = 100

[node name="HSlider" type="HSlider" parent="viewpoint/GUI"]
margin_left = 32.0
margin_top = 24.0
margin_right = 200.0
margin_bottom = 64.0
min_value = 0.5
max_value = 10.0
step = 0.5
value = 1.0
__meta__ = {
"_edit_use_anchors_": false
}

[node name="nodes" type="Node2D" parent="."]
[connection signal="gui_input" from="viewpoint/CanvasLayer/ColorRect" to="." method="_on_ColorRect_gui_input"]
[connection signal="gui_input" from="viewpoint/CanvasLayer/ColorRect" to="viewpoint" method="_on_ColorRect_gui_input"]
[connection signal="value_changed" from="viewpoint/GUI/HSlider" to="." method="_on_HSlider_value_changed"]
   GDST�   �           �  PNG �PNG

   IHDR   �   �   �>a�   sRGB ���  �IDATx��;O#I�kl�b� �F\@��-f6y��$�K@"� �}| .�#pk��ĉ#A�s�+m�OB"�N�!���x̌����ꮟ���3�vտ���g�(�m�O��D��-�0ZvO]�V��P�^� H&�i�D�% ?<=��G!�@��w�,�#� h��@� ���,���߲l�l(]� �gD��H@�   �\��4��U6@#����  e 4����b�������NE<HPJ���������47�p�mS�����2��*��R��?C�%�����p����l�'� P�(T��j��R�Գ�y�mE�D�q�e��Ek�������B��W�;$ ��)6�w��v�E`����U�P��h2y�u'
e5��@��'�T�yD:����r>V��D��ހ��1��D�@-��H� L� �Te������M&��xސE �,݀$����Ύ��'���f_V��=�v�,���9"m7e8888ln�v6	 >k(�",���J���E�Rb(%�&BZĉ!H�P^w�rY@`Qd`�<�EfX݀T
��N�l�+�#�6E�a����/蝏tH(����5%�Q��B�T*MNNNz6"�� ň@�u�� ���2�����-���eai�l"�W �E�tA���ǈ@���TEI�u�dG���b�t:�~������+��2$�0NLL�x}}}�N�Ӟ7$5$�. ��{{{{m�W����������v���+��]������J]�)�~����˲�6���w	�?���ZG�K�}!��Η�AM�0D���Ȱ�x�3^�2,0!>h�M_"k}�;"%��@� haǮ0��@\`� )���C�ZC�2 9��.Y ��@� 4�eΨ��в��q�ò\�"���t��B�m��� (�����#p�	677�X���t˻�D��C���?����Z�� ����x�B�N�]^^���c�� $�pĐ�{���lG�A����;V���P����]C�=d��{9w�"�#� ��bqhhh������h˨g6J�R�IK�@��e,R?���ߞ�����A����G�����v�b	��l6�����v`���^�~�0���U*�Jm�'�J �d2�����~6�~���$+++?�#�b�,f��H���X�Q��C[�* ,˲��K�F�`(���%����s�] ��``{��D@.ǨDh"f�P��ҫzcĶ�  ��ϡ%!�g �~�y] ���P���	uXO��S>�pe��������?�ܓ/�(=�,prrr���x�>�!DL|��yytt�[�C�u�Ek�����ׯ͗���`��~�ֿG�<�HH���]�g �~\4�M���������e �~���# Ϫ��,�_ �x���������ߦi���B�U�Ƭ������������I�����ϧO�����3�L��v���؃Z4for9�m\�C��_>~l�;???�N�_8��˺pp   [[[[���������W�  �4M�P(���i�hd�����d2� 0h�O3sSSSS�J嚼��, К(�����Z�V��b��#�@*��i�s���f�����(��Ķ)hM��@�>C@sH �C��� 4�.�0��QK    IEND�B`�   [remap]

importer="texture"
type="StreamTexture"
path="res://.import/triangle.png-53a0c5b2abae92a9e7f23d30d12f32c2.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://triangle.png"
dest_files=[ "res://.import/triangle.png-53a0c5b2abae92a9e7f23d30d12f32c2.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=true
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=false
svg/scale=1.0
    [remap]

path="res://cam.gdc"
  [remap]

path="res://edge.gdc"
 [remap]

path="res://graphnode.gdc"
            [remap]

path="res://main.gdc"
 �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx��ytTU��?�ի%���@ȞY1JZ �iA�i�[P��e��c;�.`Ow+4�>�(}z�EF�Dm�:�h��IHHB�BR!{%�Zߛ?��	U�T�
���:��]~�������-�	Ì�{q*�h$e-
�)��'�d�b(��.�B�6��J�ĩ=;���Cv�j��E~Z��+��CQ�AA�����;�.�	�^P	���ARkUjQ�b�,#;�8�6��P~,� �0�h%*QzE� �"��T��
�=1p:lX�Pd�Y���(:g����kZx ��A���띊3G�Di� !�6����A҆ @�$JkD�$��/�nYE��< Q���<]V�5O!���>2<��f��8�I��8��f:a�|+�/�l9�DEp�-�t]9)C�o��M~�k��tw�r������w��|r�Ξ�	�S�)^� ��c�eg$�vE17ϟ�(�|���Ѧ*����
����^���uD�̴D����h�����R��O�bv�Y����j^�SN֝
������PP���������Y>����&�P��.3+�$��ݷ�����{n����_5c�99�fbסF&�k�mv���bN�T���F���A�9�
(.�'*"��[��c�{ԛmNު8���3�~V� az
�沵�f�sD��&+[���ke3o>r��������T�]����* ���f�~nX�Ȉ���w+�G���F�,U�� D�Դ0赍�!�B�q�c�(
ܱ��f�yT�:��1�� +����C|��-�T��D�M��\|�K�j��<yJ, ����n��1.FZ�d$I0݀8]��Jn_� ���j~����ցV���������1@M�)`F�BM����^x�>
����`��I�˿��wΛ	����W[�����v��E�����u��~��{R�(����3���������y����C��!��nHe�T�Z�����K�P`ǁF´�nH啝���=>id,�>�GW-糓F������m<P8�{o[D����w�Q��=N}�!+�����-�<{[���������w�u�L�����4�����Uc�s��F�륟��c�g�u�s��N��lu���}ן($D��ת8m�Q�V	l�;��(��ڌ���k�
s\��JDIͦOzp��مh����T���IDI���W�Iǧ�X���g��O��a�\:���>����g���%|����i)	�v��]u.�^�:Gk��i)	>��T@k{'	=�������@a�$zZ�;}�󩀒��T�6�Xq&1aWO�,&L�cřT�4P���g[�
p�2��~;� ��Ҭ�29�xri� ��?��)��_��@s[��^�ܴhnɝ4&'
��NanZ4��^Js[ǘ��2���x?Oܷ�$��3�$r����Q��1@�����~��Y�Qܑ�Hjl(}�v�4vSr�iT�1���f������(���A�ᥕ�$� X,�3'�0s����×ƺk~2~'�[�ё�&F�8{2O�y�n�-`^/FPB�?.�N�AO]]�� �n]β[�SR�kN%;>�k��5������]8������=p����Ցh������`}�
�J�8-��ʺ����� �fl˫[8�?E9q�2&������p��<�r�8x� [^݂��2�X��z�V+7N����V@j�A����hl��/+/'5�3�?;9
�(�Ef'Gyҍ���̣�h4RSS� ����������j�Z��jI��x��dE-y�a�X�/�����:��� +k�� �"˖/���+`��],[��UVV4u��P �˻�AA`��)*ZB\\��9lܸ�]{N��礑]6�Hnnqqq-a��Qxy�7�`=8A�Sm&�Q�����u�0hsPz����yJt�[�>�/ޫ�il�����.��ǳ���9��
_
��<s���wT�S������;F����-{k�����T�Z^���z�!t�۰؝^�^*���؝c
���;��7]h^
��PA��+@��gA*+�K��ˌ�)S�1��(Ե��ǯ�h����õ�M�`��p�cC�T")�z�j�w��V��@��D��N�^M\����m�zY��C�Ҙ�I����N�Ϭ��{�9�)����o���C���h�����ʆ.��׏(�ҫ���@�Tf%yZt���wg�4s�]f�q뗣�ǆi�l�⵲3t��I���O��v;Z�g��l��l��kAJѩU^wj�(��������{���)�9�T���KrE�V!�D���aw���x[�I��tZ�0Y �%E�͹���n�G�P�"5FӨ��M�K�!>R���$�.x����h=gϝ�K&@-F��=}�=�����5���s �CFwa���8��u?_����D#���x:R!5&��_�]���*�O��;�)Ȉ�@�g�����ou�Q�v���J�G�6�P�������7��-���	պ^#�C�S��[]3��1���IY��.Ȉ!6\K�:��?9�Ev��S]�l;��?/� ��5�p�X��f�1�;5�S�ye��Ƅ���,Da�>�� O.�AJL(���pL�C5ij޿hBƾ���ڎ�)s��9$D�p���I��e�,ə�+;?�t��v�p�-��&����	V���x���yuo-G&8->�xt�t������Rv��Y�4ZnT�4P]�HA�4�a�T�ǅ1`u\�,���hZ����S������o翿���{�릨ZRq��Y��fat�[����[z9��4�U�V��Anb$Kg������]������8�M0(WeU�H�\n_��¹�C�F�F�}����8d�N��.��]���u�,%Z�F-���E�'����q�L�\������=H�W'�L{�BP0Z���Y�̞���DE��I�N7���c��S���7�Xm�/`�	�+`����X_��KI��^��F\�aD�����~�+M����ㅤ��	SY��/�.�`���:�9Q�c �38K�j�0Y�D�8����W;ܲ�pTt��6P,� Nǵ��Æ�:(���&�N�/ X��i%�?�_P	�n�F�.^�G�E���鬫>?���"@v�2���A~�aԹ_[P, n��N������_rƢ��    IEND�B`�       ECFG      _global_script_classes             _global_script_class_icons             application/config/name         graphsimulation    application/run/main_scene         res://main.tscn    application/config/icon         res://icon.png  $   debug/settings/crash_handler/messageX      M   Seems like the simulation crashed! Try keeping the amount of objects minimal!      display/window/stretch/mode         2d     display/window/stretch/aspect         keep	   input/lmb�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           button_mask           position              global_position               factor       �?   button_index         pressed           doubleclick           script         input/scrollup�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           button_mask           position              global_position               factor       �?   button_index         pressed           doubleclick           script         input/scrolldown�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           button_mask           position              global_position               factor       �?   button_index         pressed           doubleclick           script      	   input/rmb�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           button_mask           position              global_position               factor       �?   button_index         pressed           doubleclick           script      	   input/mmb�              events              InputEventMouseButton         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           button_mask           position              global_position               factor       �?   button_index         pressed           doubleclick           script            deadzone      ?$   rendering/quality/driver/driver_name         GLES2   %   rendering/vram_compression/import_etc         &   rendering/vram_compression/import_etc2          )   rendering/environment/default_environment          res://default_env.tres                 