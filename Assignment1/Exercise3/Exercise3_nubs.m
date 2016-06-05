function [] = Exercise3_nubs( gesture_l, gesture_o, gesture_x, nClusters )
    binarySplit(gesture_l,nClusters);
    binarySplit(gesture_o,nClusters);
    binarySplit(gesture_x,nClusters);
end

