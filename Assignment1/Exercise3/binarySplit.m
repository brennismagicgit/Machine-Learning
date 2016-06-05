function [] = binarySplit( gesture, nClusters )
%BINARYSPLIT
    data = reshape(gesture,600,3);

    v = [0.08, 0.05, 0.02];
    K = nClusters;

    center = mean(data);
    initDistorsion = sum(pdist2(data,center));

    clusters = cell(1,7);
    distorsions = cell(1,7);
    centers = cell(1,7);

    clusters{1} = data;
    distorsions{1} = initDistorsion;
    centers{1} = center;

    for k=2:K

        [M,I] = max(cell2mat(distorsions));     % find cluster with max distorsion

        y_tmp = mean(clusters{I});

        aDists = pdist2(clusters{I},y_tmp+v);
        bDists = pdist2(clusters{I},y_tmp-v);

        [M, x] = min([aDists';bDists']);        % find closest a/b cluster center
        [M, Xa_i] = find(x==1);
        [M, Xb_i] = find(x==2);

        clusters{k} = clusters{I}(Xb_i,:);      % Split Cluster
        clusters{I} = clusters{I}(Xa_i,:);

        center_a = mean(clusters{I}); % Calculate new cluster Center
        center_b = mean(clusters{k});

        distorsions{I} = sum(pdist2(clusters{I},center_a)); % Update Distorsions
        distorsions{k} = sum(pdist2(clusters{k},center_b));
        centers{I} = center_a;
        centers{k} = center_b;
    end
    plotClusters(clusters,'Binary Split');
end