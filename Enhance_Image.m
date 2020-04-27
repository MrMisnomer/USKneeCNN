
function out = Enhance_Image(inimg)

phase_asymmetry8 = phasesym(inimg,2,6,10,3,0.2,1.2,2,-4);
phase_asymmetry8 = 255.*(phase_asymmetry8./max(max(phase_asymmetry8)));
enhanced_image=phase_asymmetry8;
out= uint8(255*mat2gray(enhanced_image));
end